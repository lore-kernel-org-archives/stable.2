Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353924;
	b=xcoJrMwHThcKwDFibZI0zMmwqJrPpLrfB2GW8OOoN9TFbLWULBcsZmBqS4l7VSD7h+6Z
	 uWzNFN3r0Xx+n8eZacfEtJPfqb0PCoB2PjZ4ZX1oGcZFje8X525gAUnMRo0Dzl0ynjLCa
	 NCYkNB7lficLw+B5IYIQqk18r7SJu9RadF5NF+1czRxAaGsxecbDfh21JzPCSbEBv9LZu
	 tn7mMcQtZ6xgtgG6TUf6kpJXR8TQlQIZ/askCMD6k+ZtNNLMv8+L1orSVP/mEJ4rz0TwW
	 L0ywfPX4CuQv8adkHn6pRlgyw0AJecyVEbEGMtA9N6zPKSsQ8cgsE4XxrUMA7FqujSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8OvR1ocNYoxVGdiSd9mbXYYz9NdCfD4eLGs6i6y4wxw=;
	b=yIArfWPlAG+yNer381qyKlq57jZAAOwJNO8LU6sziAx/3my1RZHkMds3yBmNB38ORE2Q
	 BzOhudub+zYd3mE9KgvIoGOhZiAbmmcIoNsOSO0Q4AzydDt2CDu490/mQpm3rw711+ncw
	 yq29/iSoeaJIo45Vmak778vVhgAOCnBTWHVGnXqFqN3c4nMh9Dmbu8zzDoRk+VSf1SqwM
	 1IVoAeYhlBX+KRNQKQvaC1RLs05L98GrNwEcXzlCXVKGxmEMrlnDQZKeB5qLMceFqL2SX
	 Bmqh5WoPA1GE6WwOLljQIYm/g1xWg19C8mP0AxLfhCGrLgYLp0K/P7r9cA5Pk++v+Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhiuHwyD;
	arc=none smtp.remote-ip=74.125.230.74
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095360A2613
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C095360A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NhiuHwyD
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3a88780168dso4413701fa.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793353917; x=1793958717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OvR1ocNYoxVGdiSd9mbXYYz9NdCfD4eLGs6i6y4wxw=;
        b=NhiuHwyDait8PMOIBmp97KzB8xYjOg3eOUWVWN+6UsNvLwwsHUlO3ocgjOlBd/fhDz
         4EbnVIby0oaDb0HEIPA3+bR71wb////7vF2oa/HwX6DWbpQo7VDcjtPCgXXWOJQRJE/A
         cCCMY8sGoEplXDqM1C8C4q+NdJkuwXCKdVCdVIOZX2a+hfGfR8JU6355+1/Aat17p46s
         wh7PzYHoAyQj0VPxQCqDR+Wq07oDwxfezkcXR60dvEnDlQf6tto3M32UgyySY9bQ4SyW
         qNDeRrUgIidVsUuoVKcN+kknXR7Ggj4tz1MgrN75X87wuxAtHTDlmVRaof9GDv9nt+EZ
         ndyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353917; x=1793958717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OvR1ocNYoxVGdiSd9mbXYYz9NdCfD4eLGs6i6y4wxw=;
        b=cXBQHZdNdox1IaVvyQY8cDOxqXhFappkWNWBqxnPMLcoq6Twli3jdA3E/P+WNv6xJ1
         lKiv/pvJQbkqgoHzGlaIJaH34aR7M8PyFkS5a7VUTSLyRgPZM0UDyZ1PzYcwzVSEfFNQ
         tXlnV0elGynJEfesi90jV+/uWDGrHcvh9aJxuT3DzU/q0ITYUtQU8Zo+ndeE7CM+MxnR
         qZcdnP7nsA5HYZ7NyBb8oST/gy22cmn1EBqlI+bD1488gKKtrBnX1ymkUFh7NYw1UC6j
         ynIeCVXzUzOj/A4W7CjSVdiLZPqPqU3gTW+eflF463opIwC1x2m5/JV3Nn81xAYiaCOa
         hRUw==
X-Gm-Message-State: AFq9FYKaJlTEJj+nfFUSdlYakBRRyubQE5eA7C8ntjKVK82Q4hwYHxce
	Bn0TLPgMjP1B3qaJWs4ZmVSvEtVlLnHJ+nEyFJa2NQ7iTCym/L6j/nkyUiR0NhqL
X-Gm-Gg: AYBFou0S4WNijrwjgvVmM7k8aGZlevD8QvJFkzZ9kV+KbPeJO2Bhc2uNkS0Z/yheXa0
	1aUYm2QChv/rhKynDIW2pnLhUZ2kVEK/JTfeybxyyWGxr038G7lsvM3Q05R+CTXYoqgHD4eEwth
	P0C9uUbT3cqB7p5JDFRhb8AcnH9vzpUzfk7UI+9GbZqUBBsZpBYYDPDJ2NCCRLg80gDmdUaA+aL
	puj7hiqD4N2Eb7UCRcrELeVNc4WPYaAFYc+9cBOxnaU/hgiHInwRYc3GFQ2P3EhspGnbK6f9kKP
	9SStGMypRR9dVMG07phFYy/06dqry4IL4ezcLuBICB/0HaaZkqkhekLVQb38Sh9wSa8jXKaZ9rg
	JHUlrZ1fOoECrs2d1tdFLobcTOpvyjOw2kpsQuFynhS2rLhEHkKFTf5hpGNDExKVosb6tdIEs+q
	NCxqjec3M5oa8FXH5sYy5g0PuaJ4QSYq0aI70Pjim/Gq0Pv6PlECTvTeSaclwWC8uoaQUVnZNlB
	Z5vO7CYfjgopMD2h1X1mvy+WrzwQ9+q7u0sMANZ2L4ZMO3V0DdIhgG6UwxwQLGp8x2XXyM0lvZy
	KkXwiKQzmOLBb5Je7EYjN4UNrYZbX7PRx+FJifomZiFrFg==
X-Received: by 2002:a05:6512:b18:b0:5bf:dcd7:8644 with SMTP id 2adb3069b0e04-5bfdcd78799mr373966e87.53.1793353916631;
        Fri, 30 Oct 2026 02:51:56 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfd9c3e9c2sm270580e87.46.2026.10.30.02.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:51:56 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Frank van der Linden <fllinden@amazon.com>,
	Jessica Yu <jeyu@kernel.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10] module: fix [e_shstrndx].sh_size=0 OOB access
Date: Fri, 30 Oct 2026 12:51:36 +0300
Message-ID: <20261030095137.81695-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Dobriyan <adobriyan@gmail.com>

commit 391e982bfa632b8315235d8be9c0a81374c6a19c upstream.

It is trivial to craft a module to trigger OOB access in this line:

        if (info->secstrings[strhdr->sh_size - 1] != '\0') {

BUG: unable to handle page fault for address: ffffc90000aa0fff
PGD 100000067 P4D 100000067 PUD 100066067 PMD 10436f067 PTE 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 7 PID: 1215 Comm: insmod Not tainted 5.18.0-rc5-00007-g9bf578647087-dirty #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
RIP: 0010:load_module+0x19b/0x2391

Fixes: ec2a29593c83 ("module: harden ELF info handling")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
[rebased patch onto modules-next]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2022-49444

 kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 7f3ba597af6c..48be28a3af2e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3035,6 +3035,10 @@ static int elf_validity_check(struct load_info *info)
 	 * strings in the section safe.
 	 */
 	info->secstrings = (void *)info->hdr + strhdr->sh_offset;
+	if (strhdr->sh_size == 0) {
+		pr_err("empty section name table\n");
+		return -ENOEXEC;
+	}
 	if (info->secstrings[strhdr->sh_size - 1] != '\0')
 		return -ENOEXEC;
 
-- 
2.53.0

