Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D04439F80
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702034; cv=none; b=P3hGA2y2HUErB8Y4AsIAlDxcxEFFZyrWVWsSf2ZyCP9Za/7vI+lnWY/3vtRRAzLtWw/Thc/zhtFjud4wRg1Gc2VYjWBPp96zIG1o6sgpQNXWgpBpFVkWMIgxaXB7FBo66Hq9YsDhuqnPOaIyMQmUUwg9xdvNSV+j13mC2SlBs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702034; c=relaxed/simple;
	bh=NU6aXvRFZdfLZsRFUDigxkKLwNTarcWo8oWHPa5/VLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROWnoFu3oJWOiv3gd9UWqCAiDWefVDhItp40NvwHfnm4UzEct0kkoMe0gzxwki00pRi3PbWXmdd/V7VlzP0/nhSCJUUudhf/1xVshH/erw3OkQrU2hV+kTMRKmtLqKCDxRofYy4H6iV6WCdS8WCl20BO7FGIC1PbpPc9HRseXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Yewa/JyC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Yewa/JyC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4996c452e95so639595e9.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786702017; x=1787306817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=luyMelhPDvZXB/KS9s9YjAvQQrg/M9Advfo30AAg/4w=;
        b=Yewa/JyCrkHL8w8RhPJ6UmY2PUZ+1g603UFdWH3Wny/RfNLps07PbBSEfHnWWkaT5i
         vUUiW9dWbFkuvudq75kLtwsljYEovVkrZaCNqtNylI6N/pcrarY/Bgeq+eAVAA/JMuA4
         bqADMtVdb9cPv0Uznaecn3rFShU/cxjMvaMJij17byHk8fO2X62ZN9H6zgJB7hD8zBAT
         NNExFJa95kR57VDadZHnK9AmkEriI0ZjdxqTShMkcJfJc7v1JLLogZySRNTYa/wVudst
         QQlPVvbay/oaxGceQlcB475Zpz3QPo4BFV2x+QzIs5dQPX1hjN6KF11ZsJkewCnv4UO3
         LGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702017; x=1787306817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=luyMelhPDvZXB/KS9s9YjAvQQrg/M9Advfo30AAg/4w=;
        b=TC/UnxgED8CYnhhOBgJnIiCRE6Q7njRiw7Dx2frHWaDF9dSdvL7GPLsjg7A3ShAs+1
         VRsAtqulizAuBSX1KKHXCDK1HnPYu9oMtj3ApTCZkWpTvgLpiMNPibtGlJRCqpBPBxnA
         I6gKZvBKyGKXZA2zeIN13NwD9w7+QkYAKIPmw+dL0LJxBhy+FxsOZ2uftS/OAYI78D6E
         Peb4ValU1Na2Q0GSyQI7trX6tB1mbYCl/mE2WEfvZAjuld6z82Zyz+ohXEf89xcI0Ih9
         or75zu5K6/amB8NpbQDkGwwNu5q4WGBMR3TSyVXIqEstUATT4yLf0vT8gkcQUgc1eFN7
         3PCA==
X-Forwarded-Encrypted: i=1; AHgh+RoU8KWiulSTDB6OQsK/HZXAAjLgGJIGi3quIqSzy3IDi5BaqeR+zwzXVPdZhcjIhxPdiwlTmns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tUviXpttbd45otKtrQ8ytLUKWs8Omb0sFIW+PD2hZ0jdAxM8
	lMN9fDZHXMTdHJ2TwmhSj0UAKQ/e7tgxHDO0+ZTMI5oeOpU7OY5LJwSPB/XBtMUdtnw=
X-Gm-Gg: AR+sD12/HjfzXhnr+js/M249TX7r6iKT+/wsJmF9CbndgvI8faQL24xKQ6KiBxRc8zc
	ihNeBZwcFSxr638eU/LUm0294h8/MBmvl/N6CwRRHTecmsv0yGkJGgte0ebF5FtsGzdMln9cKXk
	1xI60FHnSjOjQdgS32xJMDl/vLbfCD9MfQrdV8V7ECJu/AE//XaVRMNACtEhUQb9VDeUPYNTwgS
	ay5Dm/O1JAwVRw8MdEgoNagQyHIaz3vmUAS/7RFigGUsP1Mtkk3lbnvtmjfGk51YQE9cb0SCuJX
	VEn0SZncR0/zSFhv3xlte5cFXxuN0RWXdxuFPDez8rwF42xZmbahVAj+z3XaGriuIXQPaxXj5Cw
	7JJtj5KmCTkVrOJbwoRuWV+leqWWOfPS6J4x6z9qZg4Gn+Mn0jsUWkJIgHkUz/D6lIuqObhRHdl
	rwf9E+qzyxsOCp1iSBUzk1nUy3dbJTGBRt9n0M0bHSGpG5bsf2Ios3Bvs3l1UzejUWWZ31/WMRH
	L41WmB+2EKdF1oatoxefwEMjhT2tDXWJrDy
X-Received: by 2002:a05:600c:1d23:b0:499:59a1:96f7 with SMTP id 5b1f17b1804b1-4998792aab8mr33581515e9.1.1786702016751;
        Fri, 14 Aug 2026 03:06:56 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([2001:9e8:144c:bd00:56c3:670b:dfc6:d046])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm6948207f8f.24.2026.08.14.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:06:56 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: dmitrii.omelchenko@cloud.ionos.com,
	Michael Roth <michael.roth@amd.com>,
	Diego GonzalezVillalobos <Diego.GonzalezVillalobos@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [stable-6.12 3/4] crypto: ccp - Fix checks for SNP_VLEK_LOAD input buffer length
Date: Fri, 14 Aug 2026 12:02:56 +0200
Message-ID: <20260814100652.225499-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814100652.225499-1-jinpu.wang@ionos.com>
References: <20260814100652.225499-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Roth <michael.roth@amd.com>

commit ed53a5050f42a3243a7ed8dfa49030e54034b952 upstream.

The SNP_VLEK_LOAD IOCTL currently fails due to sev_cmd_buffer_len()
returning the default expected buffer length of 0 instead of the correct
value, which would be sizeof(struct sev_user_data_snp_vlek_load). Add
specific handling for SNP_VLEK_LOAD so the correct expected size is
returned.

Reported-by: Diego GonzalezVillalobos <Diego.GonzalezVillalobos@amd.com>
Cc: Diego GonzalezVillalobos <Diego.GonzalezVillalobos@amd.com>
Fixes: 332d2c1d713e ("crypto: ccp: Add the SNP_VLEK_LOAD command")
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[Jack: sev_cmd_buffer_len() in queue/6.12 does not yet have the
 SEV_CMD_SNP_FEATURE_INFO case the upstream context line matched
 against (it lands in a later, unrelated commit not queued here),
 so the new SEV_CMD_SNP_VLEK_LOAD case was placed directly after
 SEV_CMD_SNP_COMMIT instead. No functional difference from upstream.]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/crypto/ccp/sev-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 7c05cae7e577..6e08378eb5fa 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -226,6 +226,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_SNP_GUEST_REQUEST:		return sizeof(struct sev_data_snp_guest_request);
 	case SEV_CMD_SNP_CONFIG:		return sizeof(struct sev_user_data_snp_config);
 	case SEV_CMD_SNP_COMMIT:		return sizeof(struct sev_data_snp_commit);
+	case SEV_CMD_SNP_VLEK_LOAD:		return sizeof(struct sev_user_data_snp_vlek_load);
 	default:				return 0;
 	}
 
-- 
2.43.0

