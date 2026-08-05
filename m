Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B533DC4BD
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961871; cv=none; b=jXoY3Sa6gKGE8yQ+sOt9yUui9KN0RiI2IztLO+zXN0meZvyTIEiHqpN/gnWgvxWbWtI/V8UEmko3/Qr7wcbEsFSgEb9Mc1meEabMGdlbBPX8M6XJTogd8kVzphGCeGpiAUQKM8JunADC+ThYGXOgcsPmY1HUOW1BH5tV7tSDl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961871; c=relaxed/simple;
	bh=kN1eUXhzlmZ/uTG2/7ewWsiGSCgf0wXwrMYNI8HvUbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlSak1VMZ73FZVzPZjaaEoKGwcOL+ayxaqKXgCewj2iLb0oy10QDJPvloQqX6rQbjl1062Dwpv2cnkhLVplJAasm9M9icqpEUhRfkBkkyhKH7VKgPHfP4APt5plG9btl2ZppuKlrfI2na+Xout5Qp6ABDXoMjv/73PLjvtbcQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gGSbP4YZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gGSbP4YZ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca80d708489so198694a12.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1785961869; x=1786566669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LalWexc+0F8HjQc4krojZh1ADM6i/G7+RWOPIo9azY=;
        b=gGSbP4YZKvDYRYE5Zj86Eztn85IThpLFh7ghTOjMzg9e4k1NjRV9a7tdHvhPfriHhY
         BsNjahW6fF/z3UbCcltGej58XO3KQ+5KrE5Xp2GA3btamwAF8bxSo/Q1bgp2tZFlreqE
         0jm75XPsOXk9FaOfPGjWYbeh1mgMPAGxf5OAWJJLAi6LagxhXtzruGWYzqbfL2C119M7
         sSRiGmTUyzlGIRSp5OC2fusu35jV1U72gNq1IZafE+0nYJYLUk3cAD9E5nwwWCWGfQR0
         MJy82hS9hmHdlZ7/uac50y5uEfAfmvVUqCyDOcWQsjHWFW72v9eM7E1MZo7B7LmZz0Pm
         X80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785961869; x=1786566669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1LalWexc+0F8HjQc4krojZh1ADM6i/G7+RWOPIo9azY=;
        b=CzH4UAtVWNf+ukcVkisYNpPFzYjKCJaFzKGs8smxE7n/bgErePUaaPEWS3PXV+u1Wu
         SpE8kMVPcJswdGtniZLyrf9SutzjPMwU9VltI/TmSUt3WjgM7DzDfCKw5xF8hrsCIDMm
         Cwxx6m23e89ep51+G59EI78Fb4N7lTUIBBFluHrKjKBDppXOmU1rXOm8ygx3EB6sYpBl
         hyi4QfunYmZkwAR+8Uty3yWoQxJ0nscF28a/llDV0xXdWtWlM4BHCG6UeNSU1h98UtVB
         mM+wAm1g9mAbFBClnHJDAqIh73AE4K7mi+0MCqsrB9qX/+SHxMVPtM50b8xz+tglLoWm
         m4Ng==
X-Forwarded-Encrypted: i=1; AHgh+Rpv08sTedJmVaZTukwx6rIEcgiptu4tTM6eBbWiXSf3sbPnyAJVnta24vT/kCgkSWqvNMq2bAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeOO8Ovk7bwRnZ0kUGzmnkOZ4wLv5S054IqQpvDqZzqc6gxmk
	Tax1PJfj+qNLQ6Eip6CT0StyinE/oPjmavZMJm9RF1TB76JrImZC42gXZFzEi5oUHpI=
X-Gm-Gg: AR+sD10yh8AVHp7dfgZ+AFOGyxLXChqSpPVQNipz39z4ITNjnkqfeCa2y88KxA348Wp
	Db4u1RQgbSG+r+Ld4FvEFQ8+AL0h1IWrAhgRdn1nElSXp3Dyz/PHbkz2ys8FGE1JHsaLR4zT+6/
	rfg9TycyfYE/+3aEojrfRUFa2gAjeyiM3uujfUoA89/CB5cK47q7hqGEhZ91W8lKf0s5w9bQ8YP
	LeiD0L7eRUGuerGONmOXyzn3enVkiA6yT/n8I1ZgKfANfi1QQFkq6pAld+QD0CzOHPLCTS2kIjX
	i3LY1uTufajad7/8yydEDgtKRGMUnALjcTqPQ77BHNP70eLRsfggfOvxmKEjn7z9tbXbC0eXgXd
	DZTHHojJrN/FD/YacU7HOqEEgzjd0ryaWC3wlUW0OvO9YkmS1PZA+4Sf1C6emLiYInLIFaOEaPc
	zqPVae4kCLe+vAG55aAW68w/i7GUjU5tOQHQxdld9GKuL9XFuNRhCs+EnslRICoTo=
X-Received: by 2002:a05:6a21:2d4c:b0:3c4:320a:737 with SMTP id adf61e73a8af0-3cb9c2376femr2136084637.16.1785961869014;
        Wed, 05 Aug 2026 13:31:09 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca63ce12sm20694924c88.5.2026.08.05.13.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:31:08 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 05 Aug 2026 13:31:00 -0700
Subject: [PATCH v6 01/10] of: fix out-of-bounds read in of_alias_scan()
 stem parser
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-nh-of-alias-overlay-v6-1-74f21d440819@nexthop.ai>
References: <20260805-nh-of-alias-overlay-v6-0-74f21d440819@nexthop.ai>
In-Reply-To: <20260805-nh-of-alias-overlay-v6-0-74f21d440819@nexthop.ai>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Shawn Guo <shawn.guo@linaro.org>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785961866; l=936;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=kN1eUXhzlmZ/uTG2/7ewWsiGSCgf0wXwrMYNI8HvUbw=;
 b=Pp9jRz3Hp/QzKiPlhgSbikASPf8D6CCitcDNJORdbru5ukCUr1beTjpvzpGh9tJkjqUnWxCM7
 lvW9PlMxCy7Ad1lPD2/PA8u4kwiGKLmKkPxu/siajbwzuABGHWSB7tn
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

The stem parser tests isdigit(*(end - 1)) before checking end > start
and so reads one byte before the property name when the name is empty
or all digits. Check the bound first.

Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5 [Claude Code]
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6e7a42dedad3..477017ed6f49 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1967,7 +1967,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 
 		/* walk the alias backwards to extract the id and work out
 		 * the 'stem' string */
-		while (isdigit(*(end-1)) && end > start)
+		while (end > start && isdigit(*(end - 1)))
 			end--;
 		len = end - start;
 

-- 
2.54.0

