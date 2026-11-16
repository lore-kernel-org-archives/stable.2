Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816595;
	b=WyL7iM2BLKHzheW0YvT2t7emgUG8dGlXQi2aqsv+r8FLHHovRteDr5wDXEPgWxZy+G2+
	 icH8sTOuM2ZrqNwYf/KZDXDhcrMqA6xDVvQ69l0aFaLQDKYRrI+WQS/Y5sMxXvIP+Dzza
	 mVAQYAVMVPQA/RAD6lgwxQf5ScUi6VEtRzHLCJj/zRnUkg3kSA1hqthBdQmY6ZTErcleJ
	 /ibJ8Uq8II18EKpU7ZAMtEtCjMJLQHWmVrJlCHCxiGv68gB+CXOP0ErU/Dqq0eGEFxR+W
	 unuvPuHK5pkx1MpyVFtQlIa0smJFCEOOl1nX79pYdu3hBfQhMxWmLxn2tAl84R66vaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816595;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o5VuCWvCa2JNG40/GZZECNjshrQeoVI84jBOdUuG27E=;
	b=hdkYt3fuVN4gT2f4mhZzcAZpAn6GW4CnU9DI6B1rL5JIH2Zw/aAW+pwh55oHuY9METKI
	 n84O3XhQMnU+nyM6+P0xdxV+AUMtWsFqkLxrH2W1EH9Ren7N6t5nZfSG401eCBjMa6j+R
	 mVA/EzUTkkpEtuiAbRZgT/t5Bpd5EZwuXDMvRsZ1psuPiN37+iyBBU72jp10oqgoat1Xq
	 Zt6drD5KK0GlI4sxQzikznvl5MvUzJgfRZ9IGE3aAzyZXRZEzNB5zW3/Itx2no4cOa0L4
	 xHCeX/tXmKCM97SbssinJx5CI9Fyz/iVCEin5/lBao77yU2256RS0OnzCoaHoEIN6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF22606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF22606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af404a0080f359c314da12a7.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:80f3:59c3:14da:12a7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 307F0244B66;
	Mon, 16 Nov 2026 09:09:47 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH] Update 212c2020833b ("iommu/amd: Force device table to maximum size")
Date: Mon, 16 Nov 2026 09:09:29 +0100
Message-ID: <20261116080929.108901-1-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026-11-11-1-daily-reply-0020-75e008cc30c56605257c@kernel.org>
References: <2026-11-11-1-daily-reply-0020-75e008cc30c56605257c@kernel.org>
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

From: Joerg Roedel <joerg.roedel@amd.com>

commit 6e2213dae78b41976c60133eb10cf99e81916638 upstream.

The stable backport for the commit in the subject line lacks a hunk to
match the fix on all relevant hardware generations. Add the missing
hunk.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bd274c2b4c6a..ef55c76a3906 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -524,6 +524,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		case 0x50 ... 0x5f:
 		case 0x80 ... 0xaf:
 		case 0xc0 ... 0xcf:
+		case 0xd8 ... 0xef:
 			setup_force_cpu_cap(X86_FEATURE_ZEN6);
 			break;
 		default:
-- 
2.53.0

