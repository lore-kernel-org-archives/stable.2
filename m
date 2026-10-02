Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C736F8E6
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965332; cv=none; b=ESCtGzWVEDY/N9KxjFMq/X5w3pKpoZE97pRRpQTbMZWXyt937qSdFxsV0XCcHUQXvkozJYfvt+rtx94+G4UOrTnc5UzF4dLnB67PFsQxJ9kGdvMXXr/ww/X05JsiU05RnLGPfIY3eXabr7zOl/Kz8qoDDo8Glr6ZjS+4m2X6kpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965332; c=relaxed/simple;
	bh=OmZ056pmE8+XuTrAcBI80z+F4NvkY+1WYs3uFfA6dFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HY25b1/JKUjEi2msQIwklNTFjCaQu/6D26W1v+sWZU9tfkciDaiuAVkRy1rn3m+Os0fO68N5axoHmEA7k3paOXG9Xi+xSgJdyx4u2TnnY8LyTY5DfmrCmsGd9AVd8rYzfHjYLogDzooDfY5KNjKOKkn0aWeo+tY4WFxKSEz9udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YUaS7erp; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="YUaS7erp"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso9748623eec.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790965330; x=1791570130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1c+AY9BIFo0QsNiuYQN2LRK0yYw3P5G1Duk5ldfMSDA=;
        b=YUaS7erp4DjEMTmicFflWCIkZt2ku3n9hmYKBIBMcaNhMd9TdOyHqga/yYBu+iDjBs
         zt1I10CopicUzE1SBbEuiac7/daL/rMCOjpEjmMab8/rlvAhYUTdHPhJFvgcu5a9KQAE
         vL19bZKXGVz/0+TL52Lg69Uw4KrA85GjdZ8GSzee2IgZ3v8iVkm0CPT1FVtLfr9+nczB
         yPrbROREOK2bqc6gI+EaNnyjcmVXmb/n3aiyrNyyo8wwgHd8t3nFRlTVIU04ESio/vQY
         Mbx9KHWOoQfuV8D/i8X0iE6KLhqMdz2h6dq3YVFmxEj5E27QE+hodmoWd7NDzYVK1OA1
         nl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965330; x=1791570130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1c+AY9BIFo0QsNiuYQN2LRK0yYw3P5G1Duk5ldfMSDA=;
        b=zN4XiIW8B2E/Hd3OLzPBvj+HoN9RBMuLdw3V5Irky8JLPs1L3ycgbPfVj27ktdMvtq
         +XGEBaHYa2RjnA0Jzu9JbtAYTDjvYgyERGeoq5pwvMtOjk2lKmF8emVvI4Fy0M4rvwP/
         pDETzuLl/ClBwdAwd7G7cZOlyim11EAB2qngYtBPjm4VSpcGX4XTHu4p82hRwnxyYNXq
         77s3WfGllDYPi+/vUSwtSLMHulLmPJI+Eis5NwJf2/WL0TZdjOTobKsKriPfmBsQQ1VG
         +wb98msWkpwgbqUMFtMPi5UX4TSm/Q3AtZxQAN4bd7x6zlPa0sw3w4dx6AhINGILblJ0
         /0+g==
X-Gm-Message-State: AFuF++lYLP3cR9ez71OHL5iudp513lLfM80gpSzu0lYlB+A/jSj9z8F+
	TVJs/QGyPNw7kZTAdBDuxxeqHjW+4sO5wKfLc+CD243a06wOvNWvL39wz1Yn2RO7OVsWdzbLEJ3
	iefU404nUqQ==
X-Gm-Gg: AYBFou0PdGxC+8NuyldZDTZR8Fc920wK0A4UsanaZmkK+UyDOzSg7KoYx4E8xsH8u18
	P8zy4LRnJYCmpCTa+HZ2gxEIqI70h7mfKOvpk3sVov29DuGziPXofZ6U8oBsQC0yCfOQS2BXScW
	huFWbw7tExxSjzgob/HLG6u/7tpo7BZPXJPJKiCAguc5Ay3Vx/WJp2l1I+Qv4fh5MUSdAYknc3G
	xcCpwc33Zw3CXURclHg0W38ISKDtd76wcQI89SaS0YNhOt7JQRpKFlzb4dYQuISP4LLkNKaOUnb
	SwZT7A6kMAQjIwUazvJYJbbHGaPXwS2OCIHkawmP4aOTw3gPqhbziftfmlX8jeS79v86LuFKltY
	tkjfLSPHUXtYUz29ElFuHHzp8uWwIlZkPHiy7GDqRsTG4DYBoPVrYnKBnLY1kpaF7WrefbyVg83
	UEYLhIu9QbIZ1b21B9uGPw1qfEhHrPwYBUCQXsy7O7RB2S2aqu5Xw3/qX9UoRglQwg4Fl+1AJYq
	sez1yQyfVjSLE7LcTCdBskpAB1k7R5GbxmqDDkbwAeoxzkOk0dEPw/zw46ufAgyZQjV708C
X-Received: by 2002:a05:693c:87d5:10b0:34b:e2cf:43b6 with SMTP id 5a478bee46e88-34f14f2b9edmr3878021eec.2.1790965329727;
        Fri, 02 Oct 2026 11:22:09 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm10551449eec.4.2026.10.02.11.22.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 11:22:09 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	James Bottomley <jejb@linux.ibm.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Martin Petersen <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y v2 0/2] scsi: lpfc: Backport SFP mailbox timeout handling
Date: Fri,  2 Oct 2026 14:22:01 -0400
Message-ID: <20261002182205.11550-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha and lpfc maintainers,

Thanks for catching the SLI3 overflow in v1.

This v2 takes the ext_buf portion of upstream commit 115d137aa918 first.
That leaves the SLI3 response in the existing 1,024-byte DMA buffer while
ctx_buf continues to point to the descriptor used by cleanup. Patch 2 then
backports the original CVE-2024-46842 fix from ede596b1434b.

Could you please queue these two patches for 6.6.y?

Changes in v2:
- replace the unsafe ctx_buf restoration with the ext_buf prerequisite;
- send the prerequisite and CVE fix as a two-patch series;
- keep the generic upstream ownership race out of this backport; and
- rebase and rebuild after the current 6.6 stable queue.

v1: https://lore.kernel.org/r/20260930024505.96440-1-artem@trailofbits.com
Review: https://lore.kernel.org/r/2026-09-30-1-daily-reply-0014-lpfc-sfp-info-mbox-timeout-6-6@kernel.org

Thanks,
Artem Dinaburg

Justin Tee (2):
  scsi: lpfc: Define lpfc_dmabuf type for ctx_buf ptr
  scsi: lpfc: Handle mailbox timeouts in lpfc_get_sfp_info

 drivers/scsi/lpfc/lpfc_bsg.c |  2 +-
 drivers/scsi/lpfc/lpfc_els.c | 21 +++++++++++++--------
 drivers/scsi/lpfc/lpfc_sli.c | 20 ++++++++++----------
 drivers/scsi/lpfc/lpfc_sli.h |  1 +
 4 files changed, 25 insertions(+), 19 deletions(-)

base-commit: 79643295eba17affbd16ca97f3ef04c90266b28c
-- 
2.39.5
