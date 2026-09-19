Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F13750A9
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789798284; cv=none; b=ZlmwqxwMTCYlWLE6i5TQagFCDK9AZJlDvuR31Ej5UUY0PpUQ/jr/il7ENoy2NWvGyfIBSc+j2cEpSwUbCdI/tPkWHCdjhLkt++YM7wUc4bgc6rVmynsoWQwo5unto25OK/RSXbH8TqkC3zQxEhHUI/uPkIXc1J7RsGl3zBeG1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789798284; c=relaxed/simple;
	bh=lwcvsGM7dkF7romeMnX3Ds75/0ZlM0UvamxerXT9LbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VFexumvyDD7inIKBPxGlUe4oHXlKor1WGklcwTsf3uf9GVmAyibZ0KY3aoowBQK1V9Ylr/hwYl33Oo0/dkS6IGoUiYDcqP+dVbsne0cXxKs1DcIBi6xYRvhKsZmIaL6X5r0aB1tUlGtNCSaWH0W00UX/TRWDNTn2rbYvYFTGOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh6Atq+H; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh6Atq+H"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b965f447cso11741115e9.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 23:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789798280; x=1790403080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wzv5spbilUO1qSlslWoXOyl5RLYwHziQsHbiWKOWqZ0=;
        b=Uh6Atq+HTmmPQ8WVekaEkCIekTTuRWPtOpnha3hf2CkpKiIGzivqKtbYwUegyZWNct
         LkFtvu/85nlr2r1+D1steBNiVBU0KW3S8mMmPgl4b7fB+RVVULF9/IK+8BOelZvB/bT1
         U5ZjlUBEaUclJKxwBgm8W1FxCdnHOjaqFEsu0t42jlrXuthmr21q88jHgnstb/n/hfmB
         LSIyuKQz2P/n3BiZINOb63bUHTksrqs72ECXZ5bdrtXqSxqLSGZmEFnDyEfEQVjFyj4c
         GN++ech6YB2l4GtQj1+j7RSoS5keexlycup7R+xjG/w2DmYIngW1mWdFLo2FHMEhg13W
         PHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789798280; x=1790403080;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wzv5spbilUO1qSlslWoXOyl5RLYwHziQsHbiWKOWqZ0=;
        b=JqpTgJZXYLx8QlldQqmmioqq4UNJkZXnB7cHl8FpF1HWiWkTquJAj1LpoxEzO4Iy6M
         OoTiYiprGtOC0QGjjwyNd4u9nkiWPHedn1P1dmXtYkQDwvIi7RqV/oIpukCLuqBPdtpk
         Yxg2eL3FZvTD3CkBar+CcK/XxN7UmslLk5Xuq/LkWw2Qc4CY2BCwdTxjNoO46DuQ0iS/
         MythTQfoxtPYnjRI/Zo7tcGaSFsYwwyycue995+4t+Wh1ih9KxQMrMCGC+7Snx1bSZGP
         fzYr3PvAwfd3loYA6ENmXRusQKl7SsdZtwrLLkqK4jTikHIiJ/vGENrGjgrysv87bpH2
         LUpA==
X-Forwarded-Encrypted: i=1; AKwUvBwuk0adhksFjBwpHvVBje9Y/BCMCiOiRFKO+//RZPb1pI4Z1fdWKB79mjWffqb203Sh9FCmgJ8=@vger.kernel.org
X-Gm-Message-State: AFuF++mKbyI50cWg4l3dfVof8lRJhHyoo/wy0ijHPXWcqdJMQRoPbI9Q
	wA06gn//Gun50nAkMTqCad1eJNBhYpgjKs3OXa8X3Qj0cQ8wSwjxc1eOWLLNP5p9m17WVA==
X-Gm-Gg: AYBFou2Wr51gjEa+tGmtbtFIUMuvoWP5hVpkYbEauehi+g8sX2DjBhXT3Hi52QSROwZ
	v8G2OxqhQb+4lL6Rv4KqIgZ85enO9hS+C0NH/F+PdMWTSW/nGfnALR/Cs1nLD49T04dVcd7K3KI
	4En8S+HtGUSzAdcg2oKfWOZD+BJXOBR+Z3Gl9qokQz6KAuHMNTbzmogRNGIZCvYf24YUHZAfWWc
	MY5ZkdXmYBwBL9fWftHLCDpAPtq4iJq9Y/fKA83ijdlGCiUuWsIvthrcOCnuSikhm3rFDZsHEjV
	rGwdBLA9ulvHuRfQsJgk+2R5w3OXOu0+btO+bwsFSmXkkANxva5e8ldooTC5Y1qLLZUUdnOOcj0
	OUtUX3oSHWzXlgUdO4rLIxuIVj5UcUQYoL+eifVUnL04T5FnUQLrsant7+bU2JIzxnopqt57vY5
	f9HJp1zmeYtaMM0yRSKvI08ScKyqxYAWXMrFYTm9maiQ904kVLj1on/3PBXvxqQLrxtCbcOJosk
	lXEsTEmOkNLOC5J7E0vhlAIoR0lZITlaGn50Jma0z+hQHGkKvRy
X-Received: by 2002:a05:600c:6211:b0:49c:fa20:cbfb with SMTP id 5b1f17b1804b1-49fc5728f84mr58855245e9.18.1789798280343;
        Fri, 18 Sep 2026 23:11:20 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1026f4sm52016675e9.8.2026.09.18.23.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:11:19 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3] platform/x86: hp-bioscfg: remove dead bounds check in audit_log_entries_show
Date: Sat, 19 Sep 2026 11:11:08 +0500
Message-ID: <20260919061108.87240-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

audit_log_entries_show() checks "count * LOG_ENTRY_SIZE > PAGE_SIZE"
prior to entering the loop. Because "count" is already bounded to fit
within PAGE_SIZE, the inner loop check "(LOG_ENTRY_SIZE * i) > PAGE_SIZE"
can never be reached and is dead code.

Remove the redundant inner bounds check and eliminate the unnecessary
"else" block after "break" to clean up the loop control flow.

Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Resending v3 2/2 unchanged: the previous attempt reached the list with
a corrupted hunk (header/diffstat didn't match the body), which is
what "patch: **** malformed patch at line 65" was. No content change
from the previous v3, this is a clean re-generation of the same diff.

Changes in v3:
  - Remove the dead inner loop check completely instead of adjusting
    the boundary arithmetic, as noted by Ilpo Järvinen.
  - Remove the redundant else block after break.

Changes in v2:
  - None for this patch; resubmitted as part of the v2 series.

Link: https://lore.kernel.org/r/20260803143037.93105-1-meatuni001@gmail.com [v1]
Link: https://lore.kernel.org/r/20260812111829.172273-1-meatuni001@gmail.com [v2]
---
 .../x86/hp/hp-bioscfg/surestart-attributes.c   | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
index b57e42f..d689ee8 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
@@ -90,17 +90,15 @@ static ssize_t audit_log_entries_show(struct kobject *kobj,
 					   HPWMI_SURESTART,
 					   audit_log_buffer, 1, 128);
 
-		if (ret < 0 || (LOG_ENTRY_SIZE * i) > PAGE_SIZE) {
-			/*
-			 * Encountered a failure while reading
-			 * individual logs. Only a partial list of
-			 * audit log will be returned.
-			 */
+		/*
+		 * Encountered a failure while reading individual logs.
+		 * Only a partial list of audit log will be returned.
+		 */
+		if (ret < 0)
 			break;
-		} else {
-			memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
-			buf += LOG_ENTRY_SIZE;
-		}
+
+		memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
+		buf += LOG_ENTRY_SIZE;
 	}
 
 	return i * LOG_ENTRY_SIZE;
-- 
2.43.0

