Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5C3FE64E
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157091; cv=none; b=Tbr4iZkdVlwdoRy5viArWXqmLuNLih+AnVOS4yOA/z27DoMkarRRRaquOHS41NTeTXlmQ7iSENdmZ1oREWNeIqDbqlConqEEUzfonXjPMBxhsZ1Wzmk2ST/68YP84xreOj+kygGJEdcdP/1zC2TGp0Pl7Yr2SdI0TOM+55biu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157091; c=relaxed/simple;
	bh=4S9VrnkVk/Jnnwkw9WnKREUKwo6wJLcjp2BdxtYkgVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eccMauR4/aXl1JAmHNlVCD9+JWyrtTVk8LWEw/RwE3ocCUp4EilWxIfQjtIinmpv321YTQqs8xogSwWSHFq55Fk3SbfMCmvsMEFa/w5A4vVLDLrAZNmNm4EWIqlh/2tKwtP4lIZa2C69TdFmlPpxmcDNgbVrLdXF7C9x5Xu51Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=yENEnbiv; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="yENEnbiv"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso1955747a12.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785157086; x=1785761886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WT7tHWse3W4hfBtv2lPecVh078HRIciCJdRTk6IvWWs=;
        b=yENEnbivviQI6o9KtaNG3nr3tX9R7vjH3SKAhVjcZK54XQ3lVGIMI6RTbeV63UO94v
         bz2X9wVckUQ++sxVTyGLpjb3sEmNSJnE+/WTmwfPKmEwq1evyjS10Ji40uGCfmK2IAS5
         KJpEpPENwgQNPASx2/2lVO1GscGEIChFuPBppVv3JSJMWz8FrS6xPXicO067iT/CDhCV
         r3T7FUBL17x8AtyS1k0Pcl66bTtUX+Z9wsXxFQvZPTPDf6uKwr0nG3Y/bJSFl9DyEhym
         5qZ/a6jvkVhZyzk7qdHz9pYwmQxfcjc4kA83Ayx8UL/F5vwqLywINYooyfMT9s668LlJ
         BjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157086; x=1785761886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WT7tHWse3W4hfBtv2lPecVh078HRIciCJdRTk6IvWWs=;
        b=GXYxalrKC8m/77kBRRfTQ8Ss0Rff3EYXkOuUBh5JeCpScdhzJsJZuv6nllrkB2o+XF
         GxJyaP5BvTZO1XCfvUV4ab84Rs/W4dsk9ZlwFfjMMZl0YWyLT61RO4DRAmcIugsMU0hg
         iC2sKaCwQ/ggBB9d2CKe6Uc2uQJVuAEl0ttf0+7qL1rqzJyAMEaCXz2cDoujz3p6cVz/
         w8n+TPaZaVRn9StZEhq9TBgQSRHU2WeKNN+bNMXt8t13YgRoZ1czz8TW2Uumd4+WwXhj
         AHWLfCs6luN8u7/T9KegKfS0goSt9KEh9aU8lk6C+B1jLbk17OeHozzRQVxEOm0gza8Y
         Bmdg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0+cToPmSw2VboSmHSmTuHaSDowLib3zoNHHystr7WMcUL2vQch88Ym/Jj7hLny+yMimXDuEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxPr7eMobPj5kwPMkZJE8rGNyoD6IJwJl/sE+dapJsATtXDAY
	tW22XYEUIjQ+kd0KInXSvW8kMROHOMCo5UAV1iaGEoV+dISAcl1ixWHYmvAF2iapREI=
X-Gm-Gg: AR+sD13jJZAGaAt8gCksf5uK7hQVzyR9bkxAZv1b1GO9Hom+W+ehxXLXikg7ilUyEjI
	/3kZ/6nv9Dzy2tiTfR0Hlb0rIEdXDbQH8iJTaHzeRKpxwMTVfdECa7zC4umbN/nqv2lWHT7QKzQ
	l+AjIv5F8uwJc8U9FFxl54Tnr9XpOA512CynoBdjIX+YW/aQC0NxmW/QYvAkxoBeMqW4Y5gZt2C
	7WKW4MUqcog0vd04hcPb260GotFFKDosnjsH0E7+Cyc+5SPPAdrt2062cFNRvIP40OwRafgUrYX
	630DWkSMYDSz+p2JumiPCFAYhE0TrSfg4sgJanGL8ERbqBNBoXCzltReVUspgz3gXEJ8x7oKdy3
	um3wpTPu95gN0xILN2r+X/6aNiHHh9oUYoJm7PHkvsybGhRDZxCS8mqRvyzNqE6pSECdgWCe9xK
	MJOxEC8Za7EzG6PYbIVFqbEpWGrkWpXJCulZpG/S2dJ/qOY4Q3Nwe0PwgrcRd8j7MrXf4DTQ76n
	K8e0T9lyNRaFemzssFA8ib+PQApZE8k
X-Received: by 2002:a05:6a20:728d:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3c67da7cfeemr8478040637.27.1785157086058;
        Mon, 27 Jul 2026 05:58:06 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13d2eb01aa0sm44088627c88.3.2026.07.27.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:58:05 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH net] net: microchip: vcap api: Fix possible memory leak in vcap_decode_rule()
Date: Mon, 27 Jul 2026 18:27:55 +0530
Message-ID: <20260727125757.134611-1-nihaal@cse.iitm.ac.in>
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
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/ethernet/microchip/vcap/vcap_api.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index ff86cde11a32..0cc0db7b641b 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2427,18 +2427,21 @@ struct vcap_rule *vcap_decode_rule(struct vcap_rule_internal *elem)
 
 	err = vcap_read_rule(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err;
 
 	err = vcap_decode_keyset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err;
 
 	err = vcap_decode_actionset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err;
 
 out:
 	return &ri->data;
+err:
+	vcap_free_rule(&ri->data);
+	return ERR_PTR(err);
 }
 
 struct vcap_rule *vcap_get_rule(struct vcap_control *vctrl, u32 id)
-- 
2.43.0

