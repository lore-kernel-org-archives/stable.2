Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6740D588
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192902; cv=none; b=Wh9BrL+91hzGtn6oV6ncfUSC6VIKgUMybWJ4arigzGHLtQBPoq5Fg8B7Wy7NWzSyDb8/qE+uXmtnvPiUFa4teTrhd8GE4ZfvAb5a8gJE9E32I9rxqxJtSCI6uC+xD3ZiXjz6VzOnoEiwi6EI6GkKf90cK/yTPi/gQ/hhMyfVYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192902; c=relaxed/simple;
	bh=3lxrWPAXShGIF4WokebW2QU8IfNJNi2a46LUj++s6BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YfVbpkZI4+l+j/fONyBXijUfdEaAN5nd1BriQlAXMGmPHKh8waGo+n6pgHj0BDHNBAj5mRsHZq0SMCGKaug7VbGqb0zT6OhsyHOEMFpL9dCSpRFCukHRslOOXplRLRLspfarFKiyl7WPTslgfay+qhfGQaEhnl+R0pQoIdQrjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=QJm9AIoP; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="QJm9AIoP"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ee37dc91f5so259698a34.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 05:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786192891; x=1786797691;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osXi6LaDiTO28e9dN3yuQi9vCnsQZpZjj6p/k64AO1A=;
        b=AAm3gkmZpa0K1/87YwqMYP6iJNtvpexNvYbeJJ4QCoupVY3fmNoujAxP/BmnXiaVfS
         M0NxjBi0V7dUVGxQMcsrzhI+jMGPiCqBRYtoOHdcWdfRLIqzf3+Qti1yse1MsCdmQTnB
         fyLlCc3YF2sO+GLTdBIyQWUGa5HH8UeCyF/DPmly8gz9enC3DBeJbXccABEh4kkqGKmU
         JqWUHpCq4YRwVw0FCNXMRueUiFFaJlzW/gJITFL7XS+Tk5htoUJm1J7c2IXDTr3dmgbF
         u7WBIkwbffKRtsBYzD+QXbpG0o2QFgCMCHmlQfakRfH3mqYhhySgacmetTk55B58XIpX
         DJ9A==
X-Forwarded-Encrypted: i=1; AHgh+RrLIX4UuH9uh8RgRt2iX7q4o92iy9+WwcMVLcZhqmCikCHmhOD+RJOI9mwpNJW2QCwuLDYIElA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD2IB34CbduOI1LFje57TwyZc96rRmfXjvNE5y80TPL3ZoK1P7
	MSqDtO+rC7fZeoZHpnMKeU0X+XHKkECoup+x8f6j9tsreNANgq/3QQEI
X-Gm-Gg: AR+sD13pz1cbO5XD9fazvcwxRSNqzT6YhaxjI12j9zDqqDnG3XdAa/I18PeXErhA1I8
	x0dckHyZRnQ/pSsWybHJ7uLfTvqBIqgC8QYOi+I6rfeDv+gGPs1ucXPDF4ZDD9kj5CYxrhpALdV
	qQz5kQ6ddncCAl+ko6A5f2s16ad/3A2jlOeqUO747+monMIjm80lU6nn5ocYqPg1mwvy7fNFnfO
	IiY8z6z/JL1MBgwkJ8I91VkVDE9xpCGE8Z7kWYdI+oC1g019KBnRh3lzCRhKzRvCeONjuAHKQrd
	UkjyGx1j0jCPVrQghkJzKaY8RCrCiqvhbIHEae0vYNijzFEPFTYcMRFKSqx6z2oEbgcDE6JL0oV
	A4jdow3gm43otJyVP6O4m1xNdW/L5/aL77Ko+EJeO0bY1fa4SB5JNb+kNvzjxrt55zcTFbToCs5
	ZnmGf14tAPiyfFhwOmPlEmjj+rQckkMD4yxAaLWrYLK/PJYwuOc892wnj6JaWgv8e+l6J2yfmJ1
	jsD00O7g12US9AjaSWVU19BWAyCIL9xhnPPSlH2/NqxbulYXMK1E8UnkKJvFYUL6A==
X-Received: by 2002:a05:6809:115:10b0:4b1:b83c:cbff with SMTP id 5614622812f47-4b1b83ccca8mr926374b6e.14.1786192891032;
        Sat, 08 Aug 2026 05:41:31 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af63d8acsm1957414b6e.15.2026.08.08.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 05:41:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44EA760CCA;
	Sat,  8 Aug 2026 12:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786192888;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=osXi6LaDiTO28e9dN3yuQi9vCnsQZpZjj6p/k64AO1A=;
	b=QJm9AIoPWD8yutMlKlTwJWZaPaJRBe74IyCDGTnc5vrunBbOsFDDOzalruPL5QirVKcAuM
	i1Lf4qGvjgHAkDVUDU+HM8s8IUiOaBbTkIzryNYdpPaLGPPAcJImvvbdBiSd2z7DFfk6lI
	rLBLC+yeySPxMbfK9ZUKDtUg14eoXE9MOIjjTFX/qdx3rh8VSUiM1wDo0wMd/ppMIHhE8G
	/djRZnu8TaKX3K+DYfo+S9X0LJbyhVFME9MqI9GprlKDxhK1+rYian30och4fc+Soc75qx
	45te9yWvH99aCFWUKPGLPuMhhKsaIH47jVsMKeURuQsLYLImPQlFMrrDj3fafw==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Sat, 08 Aug 2026 09:41:11 -0300
Subject: [PATCH 7.1.y v2] selftests/bpf: Fail unbound UDP on sockmap update
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260808-selftests-bpf-sockmap-v2-1-c7ffa9a2a652@marliere.net>
X-B4-Tracking: v=1; b=H4sIAOYjd2oC/4WOSw6CMBRFt0Le2BJaCB9H7sMwaMurVKGQvkokh
 L1LcQEO7+/kbkDoLRJckw08Lpbs5A4hLgnoXroHMtsdGkQmyqzOKkY4mIAUiKnZMJr0a5Qzq2r
 eKdHowjQFHNvZo7Gfk3uHKuXpCu3Pprd6og6RGYtKEjLlpdN9tChINWAMekth8ut5bOEn58+Hh
 TPOal00eWlkluvuNko/WPSYOgzQ7vv+BcWSsUTvAAAA
X-Change-ID: 20260807-selftests-bpf-sockmap-781db29c4f94
To: Shuah Khan <shuah@kernel.org>, sashal@kernel.org, 
 gregkh@linuxfoundation.org, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786192881; l=2322;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=qHrSlgjj3za7PJl8EnqfTO8/vRQJwzZVFEAcqanD1UA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCT/rpBMqA7HKxECSLIgqYnZkVGVBOYjQYzEOy5xK/bpGxxkt7fajmEKXvLC4qBEWYpYEJqZtYa
 +uZpLTqSUegE=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 203b06932777b9ad5085319389dea566f5c2ca63 ]

sockmap now rejects unbound UDP sockets. Adjust test_maps. While at it,
check socket()'s return value.

This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
test_maps now that sockmap supports UDP").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20260707-sockmap-lookup-udp-leak-v4-4-f878346f27ab@rbox.co
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
Hi, backporting commit 66efd3368ae1 ("bpf, sockmap: Reject unhashed UDP
sockets on sockmap update") without this one broke the selftest in openSUSE
CI:

https://openqa.opensuse.org/tests/6147940/logfile?filename=test_maps.tap.txt

Changes in v2:
- Sign off
- Link to v1: https://patch.msgid.link/20260807-selftests-bpf-sockmap-v1-1-8c4936fa03cd@marliere.net
---
 tools/testing/selftests/bpf/test_maps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index ccc5acd55ff9..d194b44ff8be 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -748,16 +748,15 @@ static void test_sockmap(unsigned int tasks, void *data)
 		goto out_sockmap;
 	}
 
-	/* Test update with unsupported UDP socket */
+	/* Test update with unsupported unbound UDP socket */
 	udp = socket(AF_INET, SOCK_DGRAM, 0);
-	i = 0;
-	err = bpf_map_update_elem(fd, &i, &udp, BPF_ANY);
-	if (err) {
-		printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
-		       i, udp);
+	CHECK(udp < 0, "socket(AF_INET, SOCK_DGRAM)", "errno:%d\n", errno);
+	err = bpf_map_update_elem(fd, &(int){0}, &udp, BPF_ANY);
+	close(udp);
+	if (!err) {
+		printf("Unexpectedly succeeded unbound UDP update '0:%i'\n", udp);
 		goto out_sockmap;
 	}
-	close(udp);
 
 	/* Test update without programs */
 	for (i = 0; i < 6; i++) {

---
base-commit: 74b69060ba6e44e20c2e4dc1847eca21db6e4a7c
change-id: 20260807-selftests-bpf-sockmap-781db29c4f94

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

