Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032A3D7D69
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658431; cv=none; b=KqT5Ib/U7IQlbl0rYk+Ykez0j+9tLJq/asnTDimes7vdpNoNxEfZVVHMYOCJqKZAJSZSkHYtyFVm6KcvaWj+5I4hqxjxRZIl62PBFUGCXDPFRoM3ambtJxU40VyJY7oItHsF2ObRQgT/RyeWAjDHk+htCvI+5c5e45Sbt2MUcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658431; c=relaxed/simple;
	bh=f4RXPk+DjT/+LqiMjRSNWPZkwaS0NXEvZjl+IFDH2qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLYjPPwxgHYKj4N6j30OWv3Lodg2T0a3aFtQ1rK0rohoFvQetVetseV62fm0peoI5SGtlXH9pJL598yUu405Th5DOHYOQ9HJumF/qqeeg7jbrQW+EprTWoF3Ch2/XvhZDMFmkcTI/kJKJXfFbxL7j4CeXk88HJNtZ+fcXeFmfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=JtK5PzfS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="JtK5PzfS"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ec1e9d3359so352049a34.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658428; x=1787263228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ob0Z3C3rB+WUj6cs9SnhoedQYgo3LMIap3aBNXhslKg=;
        b=eEMVd1n2QRxvfvD+q88jPsc2dVl138ePMhauWzD8MN9MvrvLSJ12V+TcXA0Dg87TX6
         4S65Gza3PjQleDU18colaUQT4vNOeW7Us75+XeBJ2Yu2xeEz6kE41ONoJC1rWt83iJm+
         JeBapr85P8+NMQoM1tb7U50yJ41yaSpy0tcL54/jWfsJ6spUM9RePkXbJgb6GptGsiGB
         rzphofDMw1YIJtSxQE2KUwS2ncUJH2d9x2l3Xoi8nDtJ4MGsS4zWSB5MexB7PbJPINAl
         4JmaRo9NjW84/696hjyi3Pf4bffr2q8ohwf49g580eRp+jgNz+c2I/Ap+YO85HcPRMj3
         0C5g==
X-Forwarded-Encrypted: i=1; AHgh+RooLYFTuJBEbFyybnmISsomjjmx6Xslp52ybBNJ6GVhUQnZeYay37naiKR5+Juoo1DSXMZJX7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOkrP/BmV61popgB6PgetfRnjkJf2ZsHrbuYWFFbHtQ0/gk+UP
	4Jis+sbccWwoMP3Iott8PS57Y/LS9dKfl9rxaLT6amgm11pn53+1IVhA
X-Gm-Gg: AR+sD13JaQhxMjMs0+KCjmrg+fSZeLf8qrq7t38EzNyn0ePO45YfvGjS+xldmgYDt8V
	R+0cvvsRTzTIaTxQ1pjvEmiyDCq+B9pk/Qitm1ZMHyj4iUqmwV5E+nlWalhZHDMylbo4dwmvTZr
	4STW9l9Tdam5Xu95h9v7ocgMnVeoqLwPocq6+xNVtPhMC7XrgxByVXm37MelFVxiMODPIOOCL8g
	Fi1ufagWIuQm8yyEooFcqpjka5oxHoy+5vk67Sf7B0ScgOPpIZ2Y8Nfxg/SEWx7GtCZsBqnXsud
	mSlzosJ/ATwa8DfVR+J6EW+NCofBU9FGJ9sVco6ogB0KYgCZ+w9rg+jfYCxDSCQ2Z4gKXzwD7sg
	xfD/OS/A6jzMdhGA4H1WbLWVTiyN3yY2FigFZBScWa7NOqt9ZIcopsCZlPazWYw0HFIjS33oOqy
	mh1wFqVKRRPcmdf/wFqFA0OwqroJGgRq/iU1arLdRWVceRZVjJyTuMSSPKUwcUTDdwTKvkAREBY
	AAZpOWLA8tTHyoD8KjU5YrIIyS+VHDv2WPKjH82If/Tdtv9Edua25MFtz6n10ReeQ==
X-Received: by 2002:a05:6830:67d9:b0:7d7:58b0:7685 with SMTP id 46e09a7af769-7f3de65011cmr878478a34.13.1786658428265;
        Thu, 13 Aug 2026 15:00:28 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3c9e23b6fsm3274625a34.25.2026.08.13.15.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:00:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5317760B53;
	Thu, 13 Aug 2026 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786658426;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ob0Z3C3rB+WUj6cs9SnhoedQYgo3LMIap3aBNXhslKg=;
	b=JtK5PzfSxlggPYxG39CS2LwWmcY09hVT4nbQof9gQDYdmoNozyxS4r0XphDaFEtqcK+F61
	/qygU/Bfq68LermI/jAGU2xtwdtwHs5ME/KML8AEdm74DzKTOi1Z/V6F8w2xYY2IK9Bs3t
	3ajDRnNc2abldtcaS2yMF9zRgjlzWAktDda88RHS8dzepr3uQjJSj/mm0zSylciqOvPwYH
	OvSdSBlJV6GAlPkKu324q/92ghC1JCZrdBm4AOoKwPAWYPD7wkVVXz9o2HxT02UAUj/rE6
	XwX99eBKRhVZ8oYYzJTZBmB8Rra4HnJPH+Axl8DfjIhdB6IppZgsyUxV8KcP4w==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Thu, 13 Aug 2026 19:00:05 -0300
Subject: [PATCH 7.1.y 4/4] selftests/bpf: Adapt sockmap update error
 handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-4-cd5c51e7dcec@marliere.net>
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
 Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1786658405; l=2951;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=daM25mJqeCkkst7bMwP8EsNfCCYMsTYMH8Ejt4bMwIU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJxktk0EEhkgQmlas4sb6c2fSVPWUAA2GpVOf+mstP82e2srCamrmcX9/VOLrESp6J2JxDg/k1p
 tmbSAugWULQ8=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 954b24d7601a93b6089cd75397370c51674d7893 ]

Update sockmap_listen to accommodate the recent change in sockmap that
rejects unbound UDP sockets.

TCP: Reject unbound and bound (unless established or listening).
UDP: Accept only bound sockets.

While at it, migrate to ASSERT_* and enforce reverse xmas tree.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20260707-sockmap-lookup-udp-leak-v4-3-f878346f27ab@rbox.co
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c       | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index cc0c68bab907..1c96a3cf4b97 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -53,8 +53,8 @@ static void test_insert_opened(struct test_sockmap_listen *skel __always_unused,
 			       int family, int sotype, int mapfd)
 {
 	u32 key = 0;
-	u64 value;
 	int err, s;
+	u64 value;
 
 	s = xsocket(family, sotype, 0);
 	if (s == -1)
@@ -63,11 +63,8 @@ static void test_insert_opened(struct test_sockmap_listen *skel __always_unused,
 	errno = 0;
 	value = s;
 	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
-	if (sotype == SOCK_STREAM) {
-		if (!err || errno != EOPNOTSUPP)
-			FAIL_ERRNO("map_update: expected EOPNOTSUPP");
-	} else if (err)
-		FAIL_ERRNO("map_update: expected success");
+	ASSERT_ERR(err, "map_update");
+	ASSERT_EQ(errno, EOPNOTSUPP, "errno");
 	xclose(s);
 }
 
@@ -77,8 +74,8 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
 	struct sockaddr_storage addr;
 	socklen_t len = 0;
 	u32 key = 0;
-	u64 value;
 	int err, s;
+	u64 value;
 
 	init_addr_loopback(family, &addr, &len);
 
@@ -93,8 +90,12 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
 	errno = 0;
 	value = s;
 	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
-	if (!err || errno != EOPNOTSUPP)
-		FAIL_ERRNO("map_update: expected EOPNOTSUPP");
+	if (sotype == SOCK_STREAM) {
+		ASSERT_ERR(err, "map_update");
+		ASSERT_EQ(errno, EOPNOTSUPP, "errno");
+	} else {
+		ASSERT_OK(err, "map_update");
+	}
 close:
 	xclose(s);
 }
@@ -1289,7 +1290,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		/* insert */
 		TEST(test_insert_invalid),
 		TEST(test_insert_opened),
-		TEST(test_insert_bound, SOCK_STREAM),
+		TEST(test_insert_bound),
 		TEST(test_insert),
 		/* delete */
 		TEST(test_delete_after_insert),

-- 
2.55.0

