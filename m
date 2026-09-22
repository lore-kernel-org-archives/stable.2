Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AC3B4E9D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046760; cv=none; b=VVJHGxwhbmDOvDQJf0hMYCpGHQw5TSq0XgWkWQM3SjTUaZtJ2bk8KsXVsUthjpzb9u+kQuydPlqgSGaC+dWBpCiUc8S5zP7DUuKx0tLguurb79yBOA6unzS0xXTSKwDTPdSczWkgbtGzCrM/7Qud55yGrr+pTdrqF+MkmL2N/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046760; c=relaxed/simple;
	bh=+BQj9dbyCL42y70qF7AHstEBCEOID/J0N1yR4IQB6CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suE5wbUfcMr89oI4Rcsr4tHWGeOIm8qeAHGye0iOT5BRSAnV1T+Y/9heV9AnvmUg1cPcHPmLvZWvoLlkgBvfMQQJyLaEBJi7AdHdeWrFizzbituAGc9tXjtMHRlYbJYKVhTB8myirhexKQcYKUvgMro8MRmSo1C4Dex9yZa7rDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIEyAP6f; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIEyAP6f"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so3336405a91.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 20:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046758; x=1790651558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZY0hZxTWnQbFcNW5wJVS19aTr5JPFXzLhgUi2a2b4M=;
        b=jIEyAP6fuE3vc0pRe2ORyhuMInX+gps2OLyPEcjhNQ5SoLaYwoxCgOJVjZBCdwlzwC
         1sJ8/appFDd4WvM/mvirjJ1Mj22Hya/Q7a1OgDa8/HszEqsyeXVj8J8kEHTiE+YyjN+a
         jid++Qm/v94YyImlubjiLGWTPUeL7NeB3Jlq/XzUGFWv/AKBljJ2mLkHaYAmrly7GZLd
         a7m6i9e4ZHsbHqogDuyL/cTIJ6AFMYpPzY7ObfbDkn5TD1YXyF6J0afsuaWywFN0DrSb
         paUkM2S/YjQQYXka784WvMZVrzLPe94i6KWbrhG4nRO3QuosGe6ESF5zWzE/uZyaAO9H
         I+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046758; x=1790651558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZY0hZxTWnQbFcNW5wJVS19aTr5JPFXzLhgUi2a2b4M=;
        b=whApSc4lQllTT7qwOC1W+4t9WcKhJXjm32lVbsg/evc3VyG56hJu9uUw2DTYwlVYek
         adlGF+b6cyGH83fYDzY6V2hzxWD4IYaTxlf/l4Gp3McBgl/Cp9Wcm/x2udvawLtcJtf8
         dxI4nRZToCcY5xbyg4jVKtWHe5pReDi+EEDhz7x6PaKKM6e9DFeKW4dxTPevNlIC0oFE
         wmylRvIuUTkhwTd+KIJrXFkpUZVyrELnwREDhVf4fUqKvmHMmsC9qUORygd9pGlotocT
         7f+8C7tWXx9mysiVHxZ9qCloaoaNjKIuTrJElAFaCzt5BE0cAHgyO+k7vwMIL9qFYmEF
         Xi8A==
X-Forwarded-Encrypted: i=1; AKwUvBwRFwHk24CQ6IEnUF91sFz5qMmXqv3ZWAWExzt9VeP2gB0bWrAO/sJCCgEdTljyTDl/T44Af5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lATwbkIFe8l/FgNPrvHcuUtdFLp4VxKBjJCpVA2nEzMKWM5/jA
	RYLvQvWTSZYCOFJwchWfn0rcFyGFv+1iNzsMf2ajZNpVj+H0FP7RZW4/
X-Gm-Gg: AYBFou3gVxqTg+DVgsMBFKbky+Rw6tkfs00FmB3BXf6H29DDwwjM+X429+zY0emMeJK
	LCUu5gqQ2YLjyy7lNBi6Aj+IE6N0ol/n7MVYCrRfMtQ7ke7HLdo8YYR8Hkva2zcu5RfAGqrsQlo
	eYjhQOVettGyFeehK3hc3Y5vy98Af3VN6jHhLqGDVxPhtE1EdT10+QrxCbGCR6K4VEgYSXTdmFp
	YPljy4ItIrh+/v4wrw0GWPDv3z7/QajVN84uCTVMpmDb30aGyt+QZgJ4QaAxaHlRBNOy/JoIAWN
	YuKBGXWGr5xAQ0TrPxps0/OiHyErZeSrA8D9GPTlb3eQVeKnjUn0RyM97WHq65QuSQm1eXfGpah
	xFSYS8J9wcXwgfUM2x0rOR4sGQcbQqLv09Wxtg+XA1uYuI2nZGK3KwjGLN0vkLYbWegOzSZlDBm
	hRA0v/uanU51UJ8zwPLqsmuQy+vlfCA9jgOoV2VzafxZqMyagREWbIF3kMiS9j9Ih5QvbFio66i
	xQQ9JzodHzo3Zq0jrB1gw==
X-Received: by 2002:a17:90b:4ac6:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-39e54c01efemr18486080a91.14.1790046757934;
        Mon, 21 Sep 2026 20:12:37 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cbe3714sm294627a91.0.2026.09.21.20.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:12:37 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: kees@kernel.org,
	joel.granados@kernel.org
Cc: kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sysctl: Negate before converting in the int read path
Date: Tue, 22 Sep 2026 11:12:27 +0800
Message-ID: <20260922031229.2300283-2-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922031229.2300283-1-zhanxusheng@xiaomi.com>
References: <20260922031229.2300283-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_int_k2u_conv_kop() reports the sign through *negp and the magnitude
through *u_ptr, but for a negative value it hands the sign-extended int to
the converter and negates the result:

	*u_ptr = k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;

With div_hz() and HZ=1000 a stored -1000 becomes
(ulong)-1000 / 1000 == 18446744073709550, and negating that wraps:

	# echo -1 > /proc/sys/net/ipv4/tcp_fin_timeout
	# cat /proc/sys/net/ipv4/tcp_fin_timeout
	-18428297329635842066

Take the magnitude first and convert that, which is what the open-coded
version did before commit 2dc164a48e6f ("sysctl: Create converter
functions with two new macros") folded it into a macro.  The
k_ptr_op == NULL branch was already correct.

proc_dointvec_jiffies() and proc_dointvec_ms_jiffies() are affected.

Fixes: 2dc164a48e6f ("sysctl: Create converter functions with two new macros")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f7b75985d542..38597f26b34c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -483,7 +483,7 @@ int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
 
 	if (val < 0) {
 		*negp = true;
-		*u_ptr = k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
+		*u_ptr = k_ptr_op ? k_ptr_op(-(ulong)val) : -(ulong)val;
 	} else {
 		*negp = false;
 		*u_ptr = k_ptr_op ? k_ptr_op((ulong)val) : (ulong) val;
-- 
2.43.0

