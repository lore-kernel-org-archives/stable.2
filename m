Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2303F99F3
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597308; cv=none; b=GE5qW81VkWNcWTXq4auquyeCgNoo6qxF0wUSFGeRm1SuoeT/6+feO9UaaxfqsenkhzGyJmSd8/t9j3vtgYEhYnaTxcl4G8rBfpE/TOK4F3R2iC3LcgvT5kVAitxlrD0SqSp8uWqYPJOfIdMSt6kxlEalfpV72IhsZ4R8FefeQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597308; c=relaxed/simple;
	bh=eqwkik/lgvYKHfEuorlU+vioLeuqnOkzq0SWO7VdYHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEHc249dcEHTMJaLUCWEEvjDdJv2i00z4aIj0CXak8h4LHhCXf1And8N29pJtFbRkyNwmlUw423LZ4rmTk7cajseVLvuHs1Asf2h1UXOETZiW5YOR7yiXkBPpC2iDL/ecm6pYSqMjMQRmQau5B1TJk2JXAnAbO/uk19jPeQU29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwEpX6WF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwEpX6WF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA91A1F00A3E;
	Tue, 21 Jul 2026 01:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597307;
	bh=k7UYeswAYt8r/k7jJfskwoU+fE2By04smf1xTLUSoQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DwEpX6WFM119i7XXaYeckem+oUI26EBBw44H4BboeKzLdnjhBffU6sZs7kAHaxA8u
	 MapzOaLsWmahmZEnOW1/+yeA+uOb9ZwmevwrB8u/XbMeniKjwOOK6YefsEhd8jNLk5
	 VoZOTH5tGRHlCLr5xooqlah0T6+ejwcG9QBGSGscEhPzml6qR6EybMgYZ1o4utYvQy
	 zmG1kGBuFaAxsDfMXk3S3TP7nHzjmuCmAaY9XqTiMa1hS5BP/SS3ktmK6gRBMjW49y
	 kxNh8+XN2C+gE/QKZYyEeNznHTD+FOUCtF92ZexMl238kFB/XqHS5Mrdpu62pSzgG/
	 ovWext/Lnw26A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chi Zhiling <chizhiling@kylinos.cn>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/6] exfat: fix incorrect directory checksum after rename to shorter name
Date: Mon, 20 Jul 2026 21:28:20 -0400
Message-ID: <20260721012821.3459448-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721012821.3459448-1-sashal@kernel.org>
References: <2026071544-able-urology-c058@gregkh>
 <20260721012821.3459448-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi Zhiling <chizhiling@kylinos.cn>

[ Upstream commit ff37797badd831797b8a27830fe5046d7e23fdc3 ]

When renaming a file in-place to a shorter name, exfat_remove_entries
marks excess entries as DELETED, but es->num_entries is not updated
accordingly. As a result, exfat_update_dir_chksum iterates over the
deleted entries and computes an incorrect checksum.

This does not lead to persistent corruption because mark_inode_dirty()
is called afterward, and __exfat_write_inode later recomputes the
checksum using the correct num_entries value.

Fix by setting es->num_entries = num_entries in exfat_init_ext_entry.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 942296784b2a ("exfat: preserve benign secondary entries during rename and move")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 39310bb9eccc57..b6e700c8a9b043 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -507,6 +507,7 @@ void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 	unsigned short *uniname = p_uniname->name;
 	struct exfat_dentry *ep;
 
+	es->num_entries = num_entries;
 	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
 	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
 
-- 
2.53.0

