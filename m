Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF0389DF0
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830929; cv=none; b=Q4O947UcKgppasIP3Ny69soKzfyCAvkjqc9CSfQDA6XKov4KoRIlINpZYmTdtMNY+iDEkk87FxQLMIHIywg8dftkfarSGdh1F6qQGRx/myQOzE4WrdmKJJwef3C+EpE5Uf8iD8tYOBmjanedBnrU9Vujae8+JnV177XAXeIMBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830929; c=relaxed/simple;
	bh=MgWJ382pjc3YS/Qw5ey/WYCKDvLWKApPLBvDgAkCkd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLwxMfpy1ZHsITRhj6dAZD2XcbgtbwgebXlmzWiJWlWIEjMWQ8iiffEn2Fm1NjLX40A76Yx760zbWcyV10DzZjr/LHSlnrgaKllLXgArASNHtoD78LmLcq/SPe/4t/hTqkirw9VVrpE5YU7eul/Y4ufpoTx2okhhyU8mWAJA0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdbaUwuH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdbaUwuH"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2e7131b94eso174781266b.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830926; x=1792435726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
        b=RdbaUwuHIu6iNJGzZh2xdR3mcbEjQev7Yjr1pT/aRT9QEe+1ClJZ9ldQSyix+3RRYE
         wRI2KIXuDI7pK7r9Exdm0mHYiYotpOJa7MuOHj3mOLbkjKNapkMPbNYJ5+YTZa6xR0j6
         MA+7xoZ3CKYNPP0EL1Srr/M7kqN8oW66iIfZZwKX2dnNHdWDv6nCk/f2h3ELvJD9We55
         LENISBn+kLSxxdaitnLTnkCJ7tjMaHQeW2r6cHDFMINy/mnsAeIlKBnZaOdey034EXgf
         kxgw2hC/18SCJAFJ3Yc9D9p13zyYzxTH8G+XdyrEXyTorkX+gOR+UB1BfmygDq+Iz8nN
         ywtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830926; x=1792435726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
        b=B0UzvgmV76IP9O2WD90iqGQuwEBhdCB0c+jlOLuWcUVthW7htcYJP1ia6wcxBZAw6H
         5gWp6QJIiyZHadpVsyZNi/GwkYd9BCTLZQoSNZqF5ORndQJxpKNob52VRhPAbgQarzGc
         fGIH+HMbyricjHHQafJy4/Ql1/DqImD5SnGuOS89y/r4pRNJPRtaJbU91UJBmlZejcUZ
         vTLStxBfsdfN2K/iWFNNb9VVftCCJDK8QgZco4B5vXrR/RE8KvLFAyq2NRZrhGS8kcme
         NfPR4XkqngpwyQG39B5lNqrfgx6l/ZnnCZHgqf8vM6qHig3qovbUw1TJxmulevwBEVHN
         /E4w==
X-Forwarded-Encrypted: i=1; AKwUvBxff0dtMnkc2AcBIrZQUVMZVWPzLwqXEdCoEjVFupAQPcRzEDTsKAjr2jLJ+DXyuCXwkAXDlus=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaXMu5jyC7roxmWYg70p+yoRBvxhsYY77QsK3BtRAPQrruRaUi
	DQKUfHpKyT6T+3TDBDOWUdVer7jCL8G/uAdtT7Crc8LCgCKjCE8qYLvw
X-Gm-Gg: AYBFou1X2thExMg6H6P3CD7LjwROcHcy30wtavTpppL3I1KZqjgftzoMAJabjc2hFOj
	WhW8v0DAfvfbF52tTDNf1/VxA1Cspuoh56c0mVmh2F0pN9lj+2Kjfs6bucRcFqvo2seQ71OckV2
	W6vFzP4MRWOSaKtHOiJWeAGqXYerStCb0ZLDW+EtNTz8fAfvHU94AFjE9XQ3ybI+2SEPB/7kgN3
	wVIOwzsA39oTpcQVoGNqBUyyMHQ7DWr/yT6eLDYmTYWTKseE+rTCrq1+AZzYN/t9L3YVJUA4sR3
	nNkXMHkMsoSwjCIcjoekqscb61TytMf1SvFocMCvRITDDEVBkQeNrC4IB7KFJpp4A7YYgfshEQG
	ywHwKcaUNMOu3eVh0x8u9DMnXCo0v3LEvybe1ozVh6cMghAvOmCbE38JRZZK1gIPXfIWW7e+C2r
	oU9Ou7hS70/PUkXnsUBjyo7s+pwLq6sAwJ78iDgS+tbfyFI2o+4/Bd7IJiNCADJiAI2kGh+Gb2U
	m/gtpSc4WkJ166XaqFx9x9nPz9p/ce5tI4kt+s1
X-Received: by 2002:a17:907:608f:b0:c2e:33f5:766d with SMTP id a640c23a62f3a-c31a9d0fceemr1026790066b.4.1791830926364;
        Mon, 12 Oct 2026 11:48:46 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] sparc64: return from the generic clear_page implementation
Date: Mon, 12 Oct 2026 20:48:02 +0200
Message-ID: <20261012184826.986050-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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
