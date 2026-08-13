Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA982369207
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658422; cv=none; b=njlN57HH+wOyhP2vozciMLalC5D/8yu/z3BTG2QfFcAEF7NWUNJpdyj2kYYfz2fw4BL3mUXDg1Td1br92kDiTMSGVR7ry/d/y2H9RVVcYI8GDt/YWwR9DkgW7QO3z5+NtVX+dhaAYfdxPm9BLMYt/GEcoNarQWKY05bbfzC0ZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658422; c=relaxed/simple;
	bh=mQcwQ1R3q9+w4Pnja3TW8A8KynezeEz74V7YlDB0Y3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlQgAQ9BujklDmuE64lnVmBWUEAz+bQfPh8+aMeuZ2+ThuucevwYBZ65shKm8hvfQHyIN+1AKgtTI/1hacmB5mlQnXUXzrx4ac9WnwxzCLNhlZF0zwzay7ytJb+o3iNhPX7f+qv3S3PHp4LUH6NC8IEZT1uRssLm+Y4x9EnJSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=xEOmibtp; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="xEOmibtp"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4560d6f82edso265997fac.3
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658420; x=1787263220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gw0jk3x9bl4CaiARThWQ74qNptN5vIYZqM7SLnsCmZ8=;
        b=FnIolofWgMt9yxzCAr47gi5ZBaaYY9C+a104Qjm6DpYCHerMAGEsks8apuhrEZXtFk
         6B2WqrSeMVtaHkGSjm/UyXVWYjwYPwzz6A/UjMsvluvtrQfGu6Wcg6KQ2C1v8Ige9/+8
         Ci3zex4SR5uzF6bYGhK5R4KLgFHVMZPHbxTYYYzHIlBHueY0uwWv9olllNlAxIDF45Je
         SLuPalnZjxDp2eiZsZtFNdXaEsQep/O2935SSz5IwzP2+1VJAfdfX68m5N21/Nf4NFtG
         dSWPKgJ20Vzi6qeu0oG84ekIuPZSCzcIY2kMbTu1Xycp/t2lZP/roFSLvg1aw/16vsk1
         Kztg==
X-Forwarded-Encrypted: i=1; AHgh+RqhiwGDb2nnx6EEwWff8bIgQusASLkP78ijVMba6Dn15Y02g8TxR4WEg18WzH370NEDbTE9mLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+wk6P7oIzyVZpyjjAwhZqBdWiEesK2YvQlHIQ+YQKjyISVx5
	UPi6KnnDJ5egvmKwggAzGNUlHwK4epd1+GA1yFnZaCYivFPRA4/Q8Ot9
X-Gm-Gg: AR+sD12FBQL363lE+3oJdEPewWZTCzhvCqss8iZ7qMojmDHEbHg73V9Md4ckKpCdEPg
	tMYOUGaFA2UV61eLkBpYX4xutZIUURXZkLUwA6HIIxpyekIiPGBjQYzKbiA4XaQo3buv1chf/8t
	YKG5AFs205zHEAOA6AtLtRwg5XzXZjiu1Ac85B8OT0/GgPHwSyQOvqwKWU5KzHvJ1ZLExwCrXRJ
	CCu6bdqjtYi2mKpn8NSeyv87yOAZ2+k1qy6BpYSqU3M/hdPHfZkGgiiymlfHnEoyIGMHbJcONFm
	0gu0JbeQshZ8k8Z2/fQ52uU8B25Hq2ssIGiNExeLL+tY3wwXO4FelEstPmA7eN9oWwwzABP0NAY
	hmvcCHpXDoIFesJGGQtONFWHwdh5qJ8EsUicuQIGjW1S/XfYaWNeSjX2ImfLYSF5uXRY3MPFDxL
	u8mYMJfV7d9/r0+k0zRZ6T7ydacluobvTOH4+GN/qpyM8w8ckZeK3YqolrcfoTNhEYfXhrorHh4
	lKqXmmXvL7sCrufNYJ8U7ndlKkvfEPQEgaWg/UDnueR6Bz5eob9oZlXh5/WJxaSFQ==
X-Received: by 2002:a05:6870:af0a:b0:459:fe2:ef54 with SMTP id 586e51a60fabf-45e91e603edmr1558193fac.1.1786658419871;
        Thu, 13 Aug 2026 15:00:19 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e8fecb5d3sm767767fac.16.2026.08.13.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:00:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71FBE616F5;
	Thu, 13 Aug 2026 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786658418;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gw0jk3x9bl4CaiARThWQ74qNptN5vIYZqM7SLnsCmZ8=;
	b=xEOmibtpET6yaGoNK5uLJsjQDJA2I2uz1h19EanDFwiykdCRFCdrXPOfHxj5YeZs5lmjzv
	m8cyCF1v1VWsYa+7ou/I0FHmGCk6vd/wFmblCBS2iZUT+N2oHMJFsndmPt3UoQKFzazbhT
	ZWy7pMVM8gEj8y+1TtvAQsB4AkhPqVe1HaSQq7BXjKrWbSnLDwSdANk4xCWFDs4Pktso75
	P+gh0a6YRgC3Dk0cvvFeO/H6tXX4VduMSWsFbfMQv1fH2mZ7OhZNn1mvtHbUSRdpjvl1qZ
	PaatT8V1Lr+reRo7LT0vivh9lPf1lG9w9rw/ATk9T+gYkiszPqkRCHrLl2RZLQ==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Thu, 13 Aug 2026 19:00:02 -0300
Subject: [PATCH 7.1.y 1/4] selftests/xsk: fix too-many-frags multi-buffer
 Tx test
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-1-cd5c51e7dcec@marliere.net>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1786658405; l=3121;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=gKdhzmxSTTYP5JOO/AWbwaJnbrAMpVVoYH9yI484kK0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFwLFJpIRUKR3XtAErPUIHJFDQFbQeJRaD11D1B0ee4BU8jxPLs6NQcaLR9XVLGoPmXaZsBcmAO
 vf7rDmDN2hwc=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit c5b1ca6a02886f00170ed91b757e244f23259e91 ]

The too-many-frags test describes a packet that is valid from the Tx
ring ownership point of view, but invalid for transmission because it
exceeds the supported number of fragments.

Keep the generated Tx descriptors valid so that __send_pkts() accounts
them as outstanding descriptors that must be reclaimed through the CQ.
Then mark the corresponding Rx packet invalid so the test still does
not expect the oversized packet to appear on the receive side.

Add a valid synchronization packet after the oversized packet so the
test can verify that the Tx path drains the bad packet and resumes at
the next packet boundary.

Reviewed-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20260719135609.147823-6-maciej.fijalkowski@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 24 ++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7950c504ed28..1c48a3b5ee73 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2229,7 +2229,7 @@ int testapp_too_many_frags(struct test_spec *test)
 		max_frags += 1;
 	}
 
-	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	pkts = calloc(2 * max_frags + 3, sizeof(struct pkt));
 	if (!pkts)
 		return TEST_FAILURE;
 
@@ -2247,24 +2247,30 @@ int testapp_too_many_frags(struct test_spec *test)
 	}
 	pkts[max_frags].options = 0;
 
-	/* An invalid packet with the max amount of frags but signals packet
-	 * continues on the last frag
-	 */
-	for (i = max_frags + 1; i < 2 * max_frags + 1; i++) {
+	/* An invalid packet with the max + 1 amount of frags */
+	for (i = max_frags + 1; i < 2 * max_frags + 2; i++) {
 		pkts[i].len = MIN_PKT_SIZE;
 		pkts[i].options = XDP_PKT_CONTD;
-		pkts[i].valid = false;
+		pkts[i].valid = true;
 	}
+	pkts[2 * max_frags + 1].options = 0;
 
 	/* Valid packet for synch */
-	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
-	pkts[2 * max_frags + 1].valid = true;
+	pkts[2 * max_frags + 2].len = MIN_PKT_SIZE;
+	pkts[2 * max_frags + 2].valid = true;
 
-	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2)) {
+	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 3)) {
 		free(pkts);
 		return TEST_FAILURE;
 	}
 
+	/* The generated Tx stream must keep the too-big packet valid so that
+	 * __send_pkts() accounts its descriptors in outstanding_tx. The Rx
+	 * stream, however, must not expect this packet on the wire.
+	 */
+	test->ifobj_rx->xsk->pkt_stream->pkts[2].valid = false;
+	test->ifobj_rx->xsk->pkt_stream->nb_valid_entries--;
+
 	ret = testapp_validate_traffic(test);
 	free(pkts);
 	return ret;

-- 
2.55.0

