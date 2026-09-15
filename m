Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD23372B57
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473237; cv=none; b=T8V6c0bCBMac64xAcWyICXmRrPEgPi0YwWfgsjAQtgdUnPpdfVnvrrKaZZcdiBZfS0WCNzOCPEme8Op06Ot0eMrBH++DvGW60j1IXqFwx9+JlTa3r61d7tnw7CG9EsAS8caQfzgUMVE9LUg4ceS1gkNYi9mKrMDYmQ5A6FvFwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473237; c=relaxed/simple;
	bh=qgr/p3hceS3VtgKFOnDdhJhC8P/qNGt2W9yjpLkmnOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hg6IJrva1hw5xnftQ7cVf9+tynPdetlwieBwqcucZbnG3afnLJC4rQzWefUkxZdaplSk9tJBO7faeQxB5N7RJYbBIH2IcSN7JWejx/8djxs1SP7RtnyEItXZTcim0Qh2KjzKLOQ9qvuiEl1czT7TVbL8tPfAPLXsApIY1rGXlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7rYIU+3; arc=none smtp.client-ip=74.125.230.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7rYIU+3"
Received: by mail-lr2-f5.google.com with SMTP id 38308e7fff4ca-3a20b70da4cso24274951fa.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789473232; x=1790078032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SP8o/AX4s37clPQoDD9t4nYTrUrCAlJE0QLNgt9QK14=;
        b=N7rYIU+3peTYpJ6+Eo+6/R4yh4LZxpwXDBZxezGYcAFt4k4g0hU+/R6BO+6Mmwt7UX
         wq+WBy7M0I8E2uJoz3Iq4uJktYwWxTokY8YouPPFtmN8mb/ObYRKWEI3Hzp7dSCR6HSp
         uZytBroAVqYbDBdDmZruoQ8COCo69G9NdHIzNboxSv7KdccbEqZ7tjCI9BBMFKFm0Ofj
         1NdMC9VhMoGb0CRwuYwfLOuB/416ZFCnedSMcdPwu6XZ15UsVfbhcQQWJZWhn1Cw3c4P
         AGVhlMdZBwk06MdT2XjFsqq+0VpWuyZcDp1wdzFD20xUz3z3SL6uIgrCpyHFGYxLh+zV
         ugiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789473232; x=1790078032;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SP8o/AX4s37clPQoDD9t4nYTrUrCAlJE0QLNgt9QK14=;
        b=2lpBlZTw4FZu8fmKnqYbFiS1C4c6ix8DTUo3JBpJUNAFru9C3HAXeBw3LwPb7JISTC
         Bh6IuDtBXGiNOuLyZKca7ASeUbQn7TYohTs9H++Dsp7ojJ6QeW/yH+xLfOGj/cszHiPv
         BA2d2yT5E48CfnM1Co5JdcBVOzFBYLHTIfw8OY+XGT4SXdLvri7k397O5Ny595dDjNSh
         L2cnuzwQcc4XQNn9UqvNWOSEkgi0bwGBAYox0woQuQDb4ojuSKt9kxD/ioCYVBs0+6Rw
         AWxD1Y+zLOL5Y/9egFUyTLHKJTPpaxqDCa+BynP5tTqIbmuHnQ1O6BpiLUyZpl7B2/Fy
         Etbw==
X-Gm-Message-State: AFuF++ml9qz583n4ErC4sh3sqyN2PPOpQLI3j0wh+BY7Thl0rlnaZZ1t
	+v/5yxC3CPPEVwshIdnvxX7hV4RRjEihv0WeEn6SsJYxnT6tO/ZxZkPDfZ56jjYEjUs=
X-Gm-Gg: AYBFou2gi6OWPhhlSfNfqn01cHbddO+Os8tM7MQhAq3cqLrUHrrH+R+sdZR9dNGgtEx
	sllDP8YW3z0a+/w1UqZz9NJZyZjCRCW1dHYBBAqNtLDSLztodi660BCopxxL2AlLhbWtoxruaQD
	UD1TokNL0Xj1/t1CKjxbIHWQO41LULPPiGVdjMFrzyZyUddIZOIwZ4qpPDH/RPyyGuDklL6FkJN
	covj/99lO+ehNTlqQwIQ4Qkkq8huCARD0tcODkKV/9nF1vrKfdKemr8IOZdPVg5wMCTEF+jfIec
	b+DJkvode/riqte0Z1dOpdICxpV/P8+kTIR0T40mgQLDjh/FnEeQsUq//Qx0PJBnTCEVdojkdMe
	CcrqQY86EbUNDsVlr/d67Tk5bRoknEhTIS+d5UQqqoer3QBJmgbAsrpk32ZvS+lXCA4m+NSFPC3
	FoJdoYE8ZAjLyewo012nIWutTvZsaZ8zB3r0Zj66jajuQrXzhxDTe/UOazPsZKNagucoega32Yl
	DEaS+rklYQbOsUnlw==
X-Received: by 2002:a05:6512:15a8:b0:5b7:6107:eb77 with SMTP id 2adb3069b0e04-5b8ae6afaf4mr1574809e87.33.1789473231548;
        Tue, 15 Sep 2026 04:53:51 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457238sm3216340e87.16.2026.09.15.04.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:53:51 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	Tim Guttzeit <t.guttzeit@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Kailang Yang <kailang@realtek.com>,
	Zhang Heng <zhangheng@kylinos.cn>,
	Sean Rhodes <sean@starlabs.systems>,
	Damien Dagorn <damien.dagorn29@gmail.com>,
	Martin Hamilton <m@martinh.net>,
	Bharat Dev Burman <bharat.singh7924@gmail.com>,
	Lei Huang <huanglei@kylinos.cn>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Lucas Tanure <tanureal@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Denis Arefev <arefev@swemel.ru>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 v2] ALSA: hda: Fix missing pointer check in hda_component_manager_init function
Date: Tue, 15 Sep 2026 14:53:39 +0300
Message-ID: <20260915115340.105976-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Denis Arefev <arefev@swemel.ru>

commit 1cf11d80db5df805b538c942269e05a65bcaf5bc upstream.

The __component_match_add function may assign the 'matchptr' pointer
the value ERR_PTR(-ENOMEM), which will subsequently be dereferenced.

The call stack leading to the error looks like this:

hda_component_manager_init
|-> component_match_add
    |-> component_match_add_release
        |-> __component_match_add ( ... ,**matchptr, ... )
            |-> *matchptr = ERR_PTR(-ENOMEM);       // assign
|-> component_master_add_with_match( ...  match)
    |-> component_match_realloc(match, match->num); // dereference

Add IS_ERR() check to prevent the crash.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ae7abe36e352 ("ALSA: hda/realtek: Add CS35L41 support for Thinkpad laptops")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[Roman: Instead of modifying hda_component_manager_init() (which does not
yet exist in version 6.1), a check needs to be added to the
cs35l41_generic_fixup() function—the very function introduced by the
offending commit, which calls component_match_add() without verifying its
successful completion.]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2025-40097
v2: 6.6 is missing 1cf11d80db5d ("ALSA: hda: Fix missing pointer check in
hda_component_manager_init function") as well, and it is the newer tree,
so 6.1 cannot go first here.
A 6.6 version also needs one more hunk than this: 6.6 has a second
unguarded component_match_add() in tas2781_generic_fixup() alongside the
cs35l41_generic_fixup() one.
Send a v2 covering 6.6, both call sites, and 6.1 
as Sasha Levin <sashal@kernel.org> suggested.

 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7b4fd95c66f9..9e6846a37d67 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7021,6 +7021,11 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 			spec->comps[i].codec = cdc;
 			component_match_add(dev, &spec->match,
 					    comp_match_cs35l41_dev_name, rec);
+			if (IS_ERR(spec->match)) {
+				codec_err(cdc, "Fail to add component %ld\n",
+					  PTR_ERR(spec->match));
+				return;
+			}
 		}
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
 		if (ret)
-- 
2.53.0

