Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0BC3515DA
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941797; cv=none; b=Cho0c2Lb2ybzT5BNJLMWnAHI601EV85KDZnbpQZ5hjvwnVYR82TgRxGM64WrO2N6J+J//B4mSf/zI4LGundpAtyjrBnECj8AKLIMU6FipdUsm4HRrD1YyfqkD64ubwtqqfw986QfRR3tDTWHjMnHjD1wtLxAYyfyiKu/qyecfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941797; c=relaxed/simple;
	bh=gC0uZsslxRCXNY4cm9GY1T5G4IEjpF+/L5QNc4/JjVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z9PT2BrR/JMkrlQYYoWa9bxEw3Tj+xs9y0DSJjX4ak4UWCU4N5bZM8oPJ6xn9NveB6TGfq2iRojrHOsS0m55PtMsDkmoYJEBeCP/xE/UPl5RzKxFJJjRU+5dV3Qg4S0LDkpvMmUXIGorHmuszSFvLClCF1DKO9idn7IsWmF4zzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=uyuLgZFr; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="uyuLgZFr"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f48c750afcso1323904a34.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787941794; x=1788546594;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HQ4RsyxQkzyVMKfdKBJF7I5R/44K+krbmEugmM1NlMs=;
        b=AElionRoGav7ODfHfOBa2L1SjAvpHZyycksDrM3r6lx34VvxIRp6aX9R6vgF38AI6H
         Ible6Ct06BVSGeD2/nMfhFtve8ED2ZorDJvKJXcND+HzWOylid5qxLHffg+7z/BH2Jtw
         a9Oi9uW7P+6MQFkzlOuNP6d1OKzjibWE93FHcghDqMQQrU+VuCbMfmbLLgpr9UDb2iq6
         8+Efe3nCcN+kNIsTeKFx5ifgV5LuZ7qvNkkTdiyJlGQdwOw/ft1Iu1DQ5WCFhimw0l9Z
         KQlGZowqbVaFJNBvbkE82MDgld5yTDe4qoZHNEXwr0fSbMS3XiX0Y3uL25yiqkiGfW++
         JJfg==
X-Gm-Message-State: AFuF++mxO+kN6dL+tGRU2Jkku1hfe/oEzFg/tHpu8epYu6x4+MftacmJ
	JblPMGPyQ6ZsJTGeQbFphDer0AMfmHfqWLt1l3Qiw0bgNkX7SUyP9A6a
X-Gm-Gg: AR+sD11KEQlJeJLPOjkNmCTMRDEkXSdFHj4Px0J6Qet6SXkJWt/QbGoOdErnonti6/M
	7u13rFCshbdDmD8mmI57dK5FKy0a3vwmNsNxzwmCheEPv8BaRTMfwlU0vMI1VDAuhQzYA2FkApC
	zauc9sgCDnbFStQqK+H/rjdzyW9+FFpIMqoL47IAm5dsouxrJ3nb38OfJgtlRaIlgFitdD0RJxb
	6epGjTVJb8MFe8Fyhxp5QxLn0mkvgZMxyAdjRiInpuLVs5MZQXsh4/U0v3zeHZccZSIDomkNhIf
	hMHdriGKhnbLBXP3+YIZouzZNovwNj2N28tylalLqYgr4/NsD/txNjCQwT1aTwj6gCGChq87Xht
	UL3KpjoQH61S+o6m1FZtqKgWq8sXqHZk1bEJgB6zdwSBwEs/vKIPjguL1svXOzqNU9vLR/3LTB+
	WEQL+3SZh6Kl4HI2TDsrCov2rKyXZEZLvldSR8eMoM+061I0HvPj0O3zQ+SJr9moUn/8e+cJ0h8
	ww/MBW2HJ2JdQYx0o5W7icuqqXIX9/V6k8E6RIGCjrBxlCknibrDL7ouCksXBfSRA==
X-Received: by 2002:a05:6830:6f88:b0:7f4:d8f4:8b2d with SMTP id 46e09a7af769-7f4f25596cdmr12439118a34.15.1787941794215;
        Fri, 28 Aug 2026 11:29:54 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa9d252asm1805094a34.25.2026.08.28.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 11:29:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 408EA60CBA;
	Fri, 28 Aug 2026 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1787941792;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=HQ4RsyxQkzyVMKfdKBJF7I5R/44K+krbmEugmM1NlMs=;
	b=uyuLgZFrlK4CxDZh+/Wxqf4+KS7+NJjioFHiJ4ThLv8d0LFWjLMXWhtn1qEG7mnoAJkxCX
	r7jBxso5Rx5YAwcRwyohQmpbpo3fsaVmPathEQx0OYABPTyveZgjTL26kJBFRBMTjI+ayl
	HaDNGonGylAqHTfa/M5g0LzZxlCaidt/CKdaI82F6INf+Zo8rV5k/LoIq+4qHytP+wf2I3
	ynp6EIyYsvJmX+oZveJ+4Zjcwz3DZUs4VTrKyjIip1zm7NOmbRx0jQa6pSx2wiPXEj0o4L
	7CLUE8K4r/rnUur83Jnpycq/mzo8L59XRJUvIV34mKaFMCOiGnx9VamUM1JmjA==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Fri, 28 Aug 2026 15:29:18 -0300
Subject: [PATCH] selftests/bpf: Fix test_maps sockmap failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-7-1-y-selftests-bpf-test_maps-v1-1-6ae8132a451d@marliere.net>
X-B4-Tracking: v=1; b=H4sIAH3TkWoC/yWMUQrCMBAFr1L228UmSBu8iogkcdNGYlqyqVRK7
 25i/2Yej9mAKXliuDYbJPp49lMsIk4N2FHHgdA/i4NsZdcqqbBHgV9kCi4TZ0YzO6z0eOu5GF1
 cr521olNQGnMi59d//3Y/nBfzIptrtD6MZkKTdLRjnThrE+gcfFxWTFMoMOAxwr7/AACwowyvA
 AAA
X-Change-ID: 20260828-7-1-y-selftests-bpf-test_maps-be4f7afcc168
To: stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1787941787; l=2608;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=htDwUonwKjpU40bex1c2CPBMGvz2uGwSURZIc7CwoIA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGSKFvgHTKF4sxFd8Equ3hRxIcKCnN83kRWcEcxaLc1H9Grg1PaNWpH5S4mmaWMB0fFUuKCOQgA
 RB4QqHwSADgU=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 27a0f3635d862919dd7e5e93e19f3f5d1b240e57 ]

test_maps fails in the sockmap test because sockmap_verdict_prog.c
drops the packet when the first 8 bytes are not directly accessible:
	  if (data + 8 > data_end)
			  return SK_DROP;

The blamed commit removed bpf_skb_pull_data() from the stream parser
program so that the parser no longer modifies the skb. That was needed,
but it also removed an implicit side effect: bpf_skb_pull_data()
linearized enough of the skb for later direct packet access.

In this test, the send side goes through the sockmap SK_MSG path. The
skb can have skb->len == 20 while its linear area is empty, so the
verdict program sees data == data_end and drops the packet even though
the payload length is sufficient.

Keep the parser read-only, and pull the first 8 bytes in the verdict
program before reading or writing them. Reload data/data_end after
bpf_skb_pull_data() as required.

Fixes: 22a0cc10dacb ("selftests/bpf: don't modify the skb in the strparser parser prog")
Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Closes: https://lore.kernel.org/bpf/e3a91acd-2b4d-4e93-a3bb-a0e9ee5ede0f@linux.dev/
Link: https://lore.kernel.org/bpf/20260701071501.39628-1-jiayuan.chen@linux.dev
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
Hi, this was found in openSUSE CI: https://openqa.opensuse.org/tests/6186757/logfile?filename=test_maps.tap.txt
---
 tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
index 0660f29dca95..3177bc5b733a 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
@@ -44,8 +44,18 @@ int bpf_prog2(struct __sk_buff *skb)
 	__sink(lport);
 	__sink(rport);
 
-	if (data + 8 > data_end)
-		return SK_DROP;
+	if (data + 8 > data_end) {
+		if (bpf_skb_pull_data(skb, 8))
+			return SK_DROP;
+
+		data = (void *)(long)skb->data;
+		data_end = (void *)(long)skb->data_end;
+
+		if (data + 8 > data_end)
+			return SK_DROP;
+
+		d = data;
+	}
 
 	map = d[0];
 	sk = d[1];

---
base-commit: 031eae08f997ca954427f27c41a0877694c081a1
change-id: 20260828-7-1-y-selftests-bpf-test_maps-be4f7afcc168

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

