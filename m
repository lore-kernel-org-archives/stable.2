Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3A339361
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957752; cv=none; b=dR7WfLvJQr8J5V5IQ+z2rH7OgDBEmWIKUl5iWMqSLU5bkzouamFrTOUUAIJDWWgtN0EaRYugJgjlTf02StfE+4yuRzXqI/1z0KVZ95YNc/3ExcpMefrvOQ+3xPdENC8NqbWtmd2e00pr8E52Kl+MNqsgZI4U+dRCX5t5kxn46/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957752; c=relaxed/simple;
	bh=Le1SYPb2jPNj5MhF8OuGIlzFKKsBR2rEDTHPqcMQNeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnnTkynFWcLgTFAAzOivCYcLLCxUcYlwz7B/IJcxS/dnW0eSjKGRV4wsXMtE5zX2ZNnPEni60ROyXc2Ak4/k8Rt5b5QslI+BYvedniSvJOMW6NSwMvuWhJmkmwVuNhbbIDnnniEMThaKY6z6axw1Yy0tCYJTjnRRyWlkRzjdWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W61Bo5gY; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W61Bo5gY"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e3dcfe205so10444666b.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957749; x=1791562549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=W61Bo5gYLf5flTB6iLcAJdoKQXBqRVe69B5nIDefiy1t9DhIV8RpCeL+5g0IMk0Dmu
         kkhGXVQJIQP/jSghoZ2tQ1vs0VgAn6lsC1ywm5rfyQCyyvlJhoRKhETZhzhkcAcTHris
         Q+/IGn2FenLTCvGrjG+DCcmukmf4SKQKxNdaKOvi+cLnb7gobd+kHB/Nd4t3/wESAyiA
         nUs1Uwi8FMD/5Zt7Ir5p9aJaEwq7WDtWIDRjCWD1zQbjEecVTIxUTpyfBheUhCU0U1Hl
         WCWpss9VpHmbTzblxvU1+SQN/jrXj57PfsJsnNX/X+fk/z0wRj5qWEhar6YHKHXGWBKz
         CdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957749; x=1791562549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=Nh2LFlnRBTLosA0Rnj1rUyQSmK1jWR3UR0/qtz1WDohIXBe7VBTyB3DW2lqHATwZXI
         mg+ceXgu4H89Arxdj9YFsfc31alx7En7ch9S2CvDcImv4AfSZ7f+ZKd2dMNqapRx8+Ui
         HwkMzFYYju24IYtDhLm6X5ahlzqvaN4w1aqUmGfq+UBwktu7PWyqeHwXRGl7CPlTsaYy
         HsfTXEtKbeeRdLpakzSY59Nos9YKIZXkTKvti1k0K+HUZAD0ahodjbeJJb+vMEtEjt01
         6OFYA9mqrBMOSBaQ/hNab18f7w0HG81EwrJcmRj2TuTEVPknH7lNvi512BjnqQINbMt1
         STPA==
X-Forwarded-Encrypted: i=1; AKwUvBxgPaqH7XUp+PGS32cbaXN9aTPHUgRe0KYq0v+TZ2qE2Sn09unVgks5CxbU4a0ZWF9tHDglSpI=@vger.kernel.org
X-Gm-Message-State: AFuF++ldON3DbKWm6lzXYXp0vunBraULBoXjq56ck9a3dLE8JK4x/Y7o
	0h3G6UNeN2QFSJ0GjsCXodVv8l9YQzQihYhG4xVvTPAV2OjK+GRUniqh
X-Gm-Gg: AYBFou3jhKYY0yBv1Q6wKPMr7y/ZR2WWuWZpucsufcYy5W/KcRxjr03CkH/jhkrdr+9
	gM1j3420sA07RuZY9Oc0UN2eTYlLSYkfzISU5Jj5dUal3pYgcoo/bWox1/irCVfBrGCRFimmauE
	oOOUPIiiy866+dzXeMt9sxpMqxW20981jkECVOIdEk5XxTE2bFqLEV91VOfCg1MHT2/H7qbjqvm
	1h9gHHZp0MzzQp3frJyxKeCFHjQlyfM/fNhBVyIi5XcW58YlPT9uNx7X1J6iADdMhDRDt7ohs1R
	8L45qcj22RsJOB1zYxtaQt6RCXP4m3W0cfLlqi8+TIkiyMvngIxTE0xD3/bEdllTPmpFlsZHC4j
	/DJ/hnbPE4ycEbmP7iGd0fNuZkAQOg8bCLRUY35NGqcQ/zM++dkGX1MIMsJkeYUXECFQXyb6j5o
	4Xuuq8Zy5vs+FWo69NsdR3c+ko1O4tgO1KJKH84o8GjV4rBEpW7TAs1Bm5IF4P3tC/xgG73UTUo
	UeqDzSiInFkk8A1f/BSxlGJzqcKRBqYSF2qZrAQ
X-Received: by 2002:a17:907:d086:b0:c2d:d408:5da6 with SMTP id a640c23a62f3a-c2e4b2417b1mr256577366b.49.1790957749284;
        Fri, 02 Oct 2026 09:15:49 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf5f4e4sm106437166b.42.2026.10.02.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:15:46 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] sparc64: return from the generic clear_page implementation
Date: Fri,  2 Oct 2026 18:14:23 +0200
Message-ID: <20261002161515.932316-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002161515.932316-1-linmag7@gmail.com>
References: <20261002161515.932316-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
Return to the caller once the clear loop completes, as GENcopy_page does.
This affects processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\
-- 
2.43.0

