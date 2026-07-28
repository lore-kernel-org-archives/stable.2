Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9A429024
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238991; cv=none; b=FCIT0gA5jV1XeW8mxxFbnQi98nDbcbsNsZi4Wgp2tDP/X0LcEVQUw7wZkYqLTVO8zIsSZ1B4mPPvV7u+EdUf/eTyR6DRHHrmkJdOh8GlPrapB+syPPzOjuALqptA175TMGGsW8n0YCU8a79zzuGWC0K/kAzsJhvV67PUulNvYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238991; c=relaxed/simple;
	bh=0euIPyBzRxpAJl+05iawUam7o4hv9536euClyCfq3S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WN6LC0fLt2F9Zug/j6UQ8ly/R1M2fEiIh3g5MDa8AYkYCvvV/qI6R7xEhYhJSlkzaHjw7D+L7YHsXZfrWYq9zvbDBNCFYGzZWmJGgkB6sz0caVjv6WIVh0n8GsYPyU1GkXEGUxr10RXbjIlo2xDjYTv2rAmeMdP5r7kEHVp01os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Fu3bRBZm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Fu3bRBZm"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceb096e675so45284395ad.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785238988; x=1785843788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=39GrJvnkpg8Y0WqMuL6o5Nxkg2xZIq2hCAlpo4jOXC0=;
        b=Fu3bRBZmPIbA/eag6vIWKIphjlhnI2HkunBnHyGaRyuZtA8xCsMu9ePRFMWgL+7tOU
         cWoDaYUA84+b4Whl6maYPq7dSsbm8nmiMfZFw2vYckWMa36Zsk9BiMD/h4ubPP3m91ny
         hHwtsjXIDaf/DEFr0f5iOagC3cPwdICrM++3icORGI0Ds7coIp8I035GpAYqGUYtAXNb
         lm4v6eAUcDgXbg7q0Ij2pNqtEMYUD0oWBIJnDE803933rY8eeT+79YheZW7ydjcjJMck
         FDVWDCejS8x2lS017gz+ZV1vTLJeYiwVd8IDhawjmUoMHKGSl/eOC5YJU6r2/umAuUxa
         8DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785238988; x=1785843788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39GrJvnkpg8Y0WqMuL6o5Nxkg2xZIq2hCAlpo4jOXC0=;
        b=oU2ImkFWdpB261SgTKE08OLiJ6YWfTZIlusG4e24+aN2xPoyAPGBWCqwmwc0NyRkqu
         0nYaDCodLiCHqKutUFjlNQvcdrytBObcT7gxFHvYlnWWl/Es5QGEzjLpMdAZf+0qWBK0
         1MAVEs9o98ROzkFwsSUL+5nCcgQz/twZ5UbQLJBxtlE0E+snaDPEef30PofRUfM5RG/F
         CpSv+X1AESMGYy0qQJ0vMhBJxY6m9LPbCvdZijhn6oBWIJOEq6XPFkBUB4MI+6AyTnar
         pBYFIhGfvN59bSgitcpa2BrkF6JQ9wBVK/0kLDN+i2SD2Hgy7UtjfM58yIn/FEANyYq6
         S67g==
X-Forwarded-Encrypted: i=1; AHgh+RoFZvDgpXIXqfGTD3LHNJ+OTw9G/DZslPaErhjoe9PtURD28G+QkNTah6xgJGOeQzQf0fycBZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/bb02yX7DuaZHKbWwCw/SJzEyxF0yjfws4UxGR3viGj2bVbq
	vPrJBqx8zyhavhOxtrKadIfsNUgfArPojqYfnVZaB0fPj/kTSYt9KO3Bo4qaGErxggw=
X-Gm-Gg: AR+sD117I0hM+wcoUeZCDR4XSb/4IGZyrdUFBsqhhYpl/WnMbKy0SyKCc8AtK4faTFz
	05kpn3gXbgspBkkKpySMnLMqH7FxSnK0ZuzJubbUuN7uQ61AohWwgHrrFn+sekCxDiWungts9tw
	sJaflWlkDMsz0zZvWb673Nf6lJax3k1D8pcZv9t42+iGBRWH5TAkJ/NUl+idk6xfxVb6OZK9s/9
	/pVi6zxNoAY5OtRYTRP1nYtqKr2k5IaoZae2DuZ2ZsFDBtpvgYxdvCiEHCHyTVtKLh373/xsO/Y
	6O1ha06q6saQsAes8vD1Jn9/EE/pgGFvjOdECzZxlE5oChqIE44F+Ct4CdB/AIoMcS1DQ4yybTg
	rUxf3tCfL2PfwHFtPoCFmlDRddz1e3IQycVA/qg6wE0K57Hv3YT2BW3A1DzUYEf3rgErFVeJ/Zd
	zoLVM8IZhyrubJOCqsqJRqxlDbbCfRI0XD3U3bj1WqSAQSWqdwUTecLvQlKbEvODcdXk2vfijfW
	Aw2m+yFlVlGR54yHqh72voI1R8vbsGg
X-Received: by 2002:a17:902:f64c:b0:2cc:98b4:e7d7 with SMTP id d9443c01a7336-2d01605dbe6mr24259225ad.45.1785238987907;
        Tue, 28 Jul 2026 04:43:07 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cfde59bc5asm50642555ad.6.2026.07.28.04.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:43:07 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Steen.Hegelund@microchip.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joe@dama.to,
	linux-arm-kernel@lists.infradead.org,
	horatiu.vultur@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: microchip: vcap api: Fix possible memory leak in vcap_decode_rule()
Date: Tue, 28 Jul 2026 17:12:51 +0530
Message-ID: <20260728114253.196398-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct vcap_rule_internal, keyfields and
actionfields inside vcap_dup_rule() are not freed in some of the error
paths in vcap_decode_rule(). Fix that by calling vcap_free_rule().

Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
Cc: stable@vger.kernel.org
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

v1->v2:
- Convert the error labels from "err" to "out_err" to avoid confusion
  with the err variable, as suggested by Joe Damato.

Link to v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260727125757.134611-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/microchip/vcap/vcap_api.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index ff86cde11a32..376be059d662 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2427,18 +2427,21 @@ struct vcap_rule *vcap_decode_rule(struct vcap_rule_internal *elem)
 
 	err = vcap_read_rule(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto out_err;
 
 	err = vcap_decode_keyset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto out_err;
 
 	err = vcap_decode_actionset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto out_err;
 
 out:
 	return &ri->data;
+out_err:
+	vcap_free_rule(&ri->data);
+	return ERR_PTR(err);
 }
 
 struct vcap_rule *vcap_get_rule(struct vcap_control *vctrl, u32 id)
-- 
2.43.0

