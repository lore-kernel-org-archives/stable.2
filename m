Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD23C1094
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658427; cv=none; b=CK7CNUBAyFxFTz3ESPwK/I7ZkLr44MY2WxNakIZzJQBNhWo8WX9VlUkmd90HKy2RUxgZjVRMrHsMjXb8z4b2HT4rqTjPInydtJePGirVlMT45eZDhNFTQ8nSoy8xq6AVRGxh/1nYzce/hwGsEh2No6ZrpFqYF3d5UbFoY0tkhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658427; c=relaxed/simple;
	bh=a2OSmh0AZi98/xngiEgf0IyijyL097hKaFeEEPXrQJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIvZbfLR5Q798xr+dTc8mNhN0mvh9oxfcttpXXguA0KavehlKWoa5Tw4FXFRxUiKYPeeqYfweeP+FUobTJ+6TD5Im806mteVFmHgbjmQD+XomA44/7UDf1f35j+T1RVKpGn5zf9dm4UZjXNwwMnmlnx1+5qus50k9OySM9LxJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ADzyFmNc; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ADzyFmNc"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-458de93b53fso208443fac.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658423; x=1787263223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7UPQuQnGTtX5sQqU130njMumgh3DmPJuNrxPRcf9XMc=;
        b=Xt+APYLxZIKoXTHtYuJ1YSoFjewyWpnCB2fGZ1rRp0YbKFcCgnhqLRxAGdSnkLu8TR
         Z77bYEH0PaTd9pm+ZRodUy/5qCmafAZpmV0fbbYAEMykv1IjWAXqh2m4udKcoHss0UEg
         lpsyacket5mWRT7yALoeaNWRqMwAxFjlQ/4J/7Rc+2PFcMdLA4SKtgjxndaHWpCJyz68
         qPQfYET+Vp+m46qiloqLSInWKg3TcfXlbdzp9ZuM99POLEByhQjh0Z840zXLXltrRz+U
         jyIgXAYLowzOfFX79piususogpUec6yaJ5Xnc7+bvtSg0qfBTiDD7r8PuHP/CeWjhOCU
         5K0g==
X-Forwarded-Encrypted: i=1; AHgh+Rr6+0a/cNGtwDIaQMK2Gyy7xwmbfEa0h9AKYuevTt0jhPxr38wcfZWsJ/L87p+q0hEuJ8fNbtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3q9bw8eHzjMLLYONCAWfdTrcE1mg9EXoGam4X5WRSXcdMJuTd
	YzOnRByRhdV6cvdZ8RLBml3C3+bJxFrNaD1e6mQoWSkocW27uuh4oQ09
X-Gm-Gg: AR+sD1128hCBVvhQelJshdPoLSf5EJZ6uJGI+me5rJpE5GzzT8UwXtmzFk8JG3EzaiM
	JD4ZBs6/iPbTYryWSTAnjZIO9Z8b9CmXF+/Zkh/WLURqgXamCJZkoozbw1DWQq575CP5GggtuX7
	b0oyBuGL40s3vE195CDFCX2WvkoVdqAckalvuzb5r7j6sT2XDYb99LfkZ5e69Us77uqsodxbfTA
	E146lIR80dgfhMm7UL4Bus0SpgZwDNKkwAIWOQxe/8QF8dhlyvUoiZZbOGapsnSVEaSfUdCO9hV
	lhZTiaYOrrAUnkycEDzdFu3pgvq7tpdI0+f0doTGw3muGDYvTywK9iroHmyjqJPb4gjxNP5lVuD
	ORn+86igiituAAsRgKYZcU3nyOZvop8yNh40lGvpvWVvm5okPzC5W1YC1ksL/+F3+5VKjx696B/
	vt7znTLeLiMHARQn24nt/v9rFqdNeeJLkUOMNI1LAdx+vFC8WqDLSYtDpfaoI58QeucGjzMfITZ
	DS1VzwwlA3gUm3ZPoxTMKrImGEaQrGygV6AHFqSkOEUc5kSr84z1DH9/NVDEjBA+Mw+A6vSKAHE
X-Received: by 2002:a05:6870:2105:b0:455:9a0a:f40f with SMTP id 586e51a60fabf-45e91f93983mr1226393fac.12.1786658423477;
        Thu, 13 Aug 2026 15:00:23 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e8f95c832sm759236fac.6.2026.08.13.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:00:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A78760CF1;
	Thu, 13 Aug 2026 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786658421;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7UPQuQnGTtX5sQqU130njMumgh3DmPJuNrxPRcf9XMc=;
	b=ADzyFmNc1V9KQJFce5Y6ag7d3bjgzbPr5Zdi2Ungq0pY0En7FCAThbyDbhCk6K3XeBwMJu
	ewaiPa8bWiOGAG7HZ8duuEuLHFe33NeTp8YYHuY6oc/8fofk/BThhIiYcKXY10GqOiw11Y
	3q7q1zYa32WHjfVbDt+JTvjwn7nx4SoNWt5+bRdGy7qIkPDVsv9oe+WFlPGZ00Yr1anztr
	ws4svmtKZvGnXfNtQ8illn0+lA7g1wKFDq5e17QXiXmnhnXAtLRBbe3XtU0xWgvEN8KtuG
	5Uqf/GUHzYoXxEeMNPAsOqvJm6zQ5hzmcKA94ti/YEuy3NGkxlxlCtUsBZnEJA==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Thu, 13 Aug 2026 19:00:03 -0300
Subject: [PATCH 7.1.y 2/4] selftests/xsk: account reclaimed invalid Tx
 descriptors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-2-cd5c51e7dcec@marliere.net>
References: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net>
In-Reply-To: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, sashal@kernel.org, 
 gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jakub Kicinski <kuba@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1786658405; l=4693;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=sCYMhfyzr1Xo+Pf6SRgXbqzjNg1WSOhwWZ0r6MIssc4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGVdMnAlvL87QEe5HaYz8ifHCEINS8j4kq7F6Q/zPaUdQsOoQZdHJXc2IQALAwWp5MPzxjRPhVb
 eIvmDEKDC1wo=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit f49d99eaee7c32badc7ddfaecbb01ce4d037d695 ]

Invalid Tx descriptors are now returned through the completion ring,
regardless of whether they form a standalone packet or belong to an
invalid multi-buffer packet.

The selftests previously counted only descriptors belonging to valid
packets, with a special exception for some invalid multi-buffer packets
in verbatim streams. This undercounts completion entries when a
standalone invalid descriptor or another invalid packet is reclaimed by
the kernel.

Keep valid_pkts as the number of packets expected on the Rx side, but
count every descriptor submitted to the Tx ring in valid_frags, as every
such descriptor is now expected to be returned through the completion
ring.

Make fragment counting in verbatim mode follow the packet boundary
instead of stopping at the first invalid fragment. Update custom stream
generation so an invalid middle fragment terminates the generated Rx
packet while Tx completion accounting still covers the complete invalid
packet.

Also add explicit end fragments after invalid middle descriptors. This
exercises the kernel drain logic and verifies that subsequent valid
packets are not interpreted as continuations of the invalid packet.

Reviewed-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20260719135609.147823-7-maciej.fijalkowski@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

[ rbm: in testapp_invalid_desc_mb() hunk, use umem_size instead of umem_sz
]
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 1c48a3b5ee73..31bf8a3fcd66 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -414,14 +414,14 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
 	}
 
 	/* Search for the end of the packet in verbatim mode */
-	if (!pkt_continues(pkt->options) || !pkt->valid)
+	if (!pkt_continues(pkt->options))
 		return nb_frags;
 
 	next_frag = pkt_stream->current_pkt_nb;
 	pkt++;
 	while (next_frag++ < pkt_stream->nb_pkts) {
 		nb_frags++;
-		if (!pkt_continues(pkt->options) || !pkt->valid)
+		if (!pkt_continues(pkt->options))
 			break;
 		pkt++;
 	}
@@ -652,11 +652,11 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 			if (!frame->valid || !pkt_continues(frame->options))
 				payload++;
 		} else {
-			if (frame->valid)
+			if (frame->valid) {
 				len += frame->len;
-			if (frame->valid && pkt_continues(frame->options))
-				continue;
-
+				if (pkt_continues(frame->options))
+					continue;
+			}
 			pkt->pkt_nb = pkt_nb;
 			pkt->len = len;
 			pkt->valid = frame->valid;
@@ -1236,10 +1236,9 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 			}
 		}
 
-		if (pkt && pkt->valid) {
+		if (pkt && pkt->valid)
 			valid_pkts++;
-			valid_frags += nb_frags;
-		}
+		valid_frags += nb_frags;
 	}
 
 	pthread_mutex_lock(&pacing_mutex);
@@ -2075,13 +2074,16 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_size * 2, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Invalid options in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Transmit 2 frags, receive 3 */
 		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, XDP_PKT_CONTD},
 		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, 0},
@@ -2093,8 +2095,8 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 
 	if (umem->unaligned_mode) {
 		/* Crossing a chunk boundary allowed */
-		pkts[12].valid = true;
-		pkts[13].valid = true;
+		pkts[15].valid = true;
+		pkts[16].valid = true;
 	}
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;

-- 
2.55.0

