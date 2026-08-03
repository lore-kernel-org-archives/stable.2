Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380BB41CB54
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767481; cv=none; b=bEQr0nd9/CTPKnRoNYBB/Iky1NiNoc3c2ciqV+X8DBQyWCFFd2qtJPVhhnE4yfXYmzkU1JmzkcVEhcIdRssdgl6r3q2xuRK9LpQcwk5pHLXfM5550hAhMGel0LZ03atB5QsCKRlOz/qrYC/Xdhgcgma/Wjo3SsL7MXTv3vHqNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767481; c=relaxed/simple;
	bh=aPETE3o1r0HQZA9wDBA5bpXSmM050p/rQxyZ/Pt3L2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVun6iycc7wrHHkxrWUSRakMwjwBrr8f5L+eTndkSaQNa/inYxzuWlczzNleC+M2rqTHcAzncht8nwLwF43UXqC0hk7ObLQaMf3agmzOHaSM8uSktg4YP2rAvf8scrUtq/A2QnT1Ebi4bdM64XHAnB/Whp52QIy6b3gVVzEAzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO9oVCpM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO9oVCpM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495437bb891so18186945e9.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767477; x=1786372277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I5CCpAh+m8Fx6ANrpP0jbYMsqCo/QP0tlHJ61+yZOVU=;
        b=SO9oVCpMeQguxxIa7MiRXp4c3nPHW255XH42M41WT9dEgHK3ATVNKn5ZmPCoyJ8uXq
         Y1AmMfEDRq9UcFMCoTga5OlmQD9nJKP+ClvI3BMP+8w9wdzmdi29qx1u9bOUXg8eNlOi
         bKGIVHgM9XyAwbELlpROyPAOlIVghdxEV7LYqsvzdLivbdSImmzSX2Jg+oj6S1lBCM6Z
         uE+ma7uVFXOk/dm1agvyrjCEU5uf8vYONW5//HjfEUZTOXv6a77qS632FoQE+UyrzlEg
         i7oAfQoijAUj/mKVo2wyRPKTJZDv4qtGqVJvgmHrvUE/oQayHhW27n1S2J8KXMW1P1NA
         rA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767477; x=1786372277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I5CCpAh+m8Fx6ANrpP0jbYMsqCo/QP0tlHJ61+yZOVU=;
        b=egShuM1Nho3jKRRYPEEClqH9YdSwd1RaLWx94U6H1bjrO0EVF3hta0dOJWHaPYp6dx
         2XFEk6vH/MKIzlHEQk7+ouVceJEcY5Xi7PFNFVd2KzM7nGumQJWaKreSsmh6LuMpi492
         ptww/f6k/MwLeAlBiG1cf8tZNQJvXeWSdMr2I5ypB5DIQOBhif60UdxwEWzq8ph+fB7k
         Dqcn7aF/6W3aO08ZGwmAIVmAtw2gpy3O733oyUgDd1JAGKMiIKKMrsdNHX7i3REa95QO
         VlwtHwjpCEdCkp3wtncS3UOaObEi+9+bRsgJ5Sjel3+AhfZYdM50TgMwRSQjADKXcKIQ
         A6bQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIhCCDi8dl+sAO4MTW5PdS7GXrysH/sfg3ez1cjx4JPP3vCEbpL/n39CErZMaH951E59YqMeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkp7jPZY44O8haJOi32VsLPq0pJVh/S1o5tnkGiMfPbLBmoHFx
	v2QcXt0da06FAkjUNTAbzEhBQkRBRqrALlKqzjmmiSDwtvBjeY2vvs4h
X-Gm-Gg: AR+sD134I3HcapwSIvECW6kRM848goqvCnBp/Rl2+KJcQVlbN4rhNWGe3GwD6oWMyny
	AKq80+axXiqfa8tiOLl6OvlSVxKdIR5G/TKfXHUgOmQndD6diaO4y7mzs83mPqzGt8aE3UFfJrz
	NWSUE/4urmtFMbo7EHp0IGzQ7SwzUaS1RGp16/zVQccq4xyhr3fyI77aFf6p0FKwVn3lUBjjgQA
	0QC+l62YHRYqYWer5GpQwQ1yddCZ/OSTZx4jg2z+9BZB5AW1mnbvkkWJ+QDHS1u3i9FnY+3ZZO4
	4jgKcb/iAPnOYwPhpc6/PAUjirGvvMYPKxuGOieWsDEinZLiFox7KspuAcgxzxjPl2J+wrCEpIC
	uliEeUJSW8lGTDPvijIdUdwsUDs8yMfM/FrN7NHXeeUE5KotQLLE0sAcHLPdFtMYkRL6t5O2Ch2
	Sy2y26TRYcrmEqWIVaFAWWS3LjzPkTD4/GYVyQ/QNeDQsujU5qXr1keIvZQG7NprACg9Fv++Bid
	rNAr2SbwzBAqbjShMSiy/Ua1YuK3pfX9B9k02y4WA==
X-Received: by 2002:a05:600c:46c3:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-4980eb8d081mr174789585e9.1.1785767476532;
        Mon, 03 Aug 2026 07:31:16 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:15 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 09/13] platform/x86: hp-bioscfg: advance elem past consumed array elements in enum-attributes
Date: Mon,  3 Aug 2026 19:30:32 +0500
Message-ID: <20260803143037.93105-10-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803143037.93105-1-meatuni001@gmail.com>
References: <20260803143037.93105-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The outer parsing loop advances "elem" (the index into the ACPI
package's element array) by exactly one per iteration:

	for (elem = 1, eloc = 1; elem < enum_obj_count; elem++, eloc++) {

but the PREREQUISITES and ENUM_POSSIBLE_VALUES cases each consume
"size" consecutive elements (elem, elem + 1, ..., elem + size - 1) to
populate an array, without adjusting "elem" to account for the extra
elements consumed beyond the first. The next outer iteration then
re-reads a leftover element from the array just consumed instead of
the next real property, and the type check against
expected_enum_types[eloc] fails on that stale element, aborting the
parse with -EIO.

This produces exactly the failure visible in dmesg on the test
hardware, on every boot:

  Error expected type 2 for elem 13, but got type 1 instead
  hp_bioscfg: Returned error 0x3, "Invalid command value/Feature not
  supported"

Note: this exact message string is shared by more than one file in
this driver (see the companion patches to int-attributes.c,
string-attributes.c, order-list-attributes.c, and
passwdobj-attributes.c in this series, which fix the identical
pattern), so this dmesg line cannot be attributed to this file alone
without further instrumentation; it is included here as evidence that
this class of bug is live and reachable on real hardware, not as
proof this specific instance is the one firing.

Fix by advancing "elem" by (size - 1) after each of the two loops, so
the outer loop's own "elem++" lands on the correct next element.
"eloc" is intentionally left alone, it indexes the logical property
schema (expected_enum_types[]), not the physical element array, and
each of PREREQUISITES/ENUM_POSSIBLE_VALUES is still exactly one
logical property regardless of how many physical elements it spans.

Fixes: 6b2770bfd6f9 ("platform/x86: hp-bioscfg: enum-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index af4d1920d488..43beb639051e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -227,6 +227,8 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 				kfree(str_value);
 				str_value = NULL;
 			}
+			if (size)
+				elem += size - 1;
 			break;
 
 		case SECURITY_LEVEL:
@@ -280,6 +282,8 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 				kfree(str_value);
 				str_value = NULL;
 			}
+			if (size)
+				elem += (size < MAX_VALUES_SIZE ? size : MAX_VALUES_SIZE) - 1;
 			break;
 		default:
 			pr_warn("Invalid element: %d found in Enumeration attribute or data may be malformed\n", elem);
-- 
2.55.0

