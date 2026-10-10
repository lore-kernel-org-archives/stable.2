Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8637389E04
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604299; cv=none; b=OYLWz0mg8MVF2oT6G45bgPmt4P+dQC4F8WZtP5azs+z9GoYd+20mUVVWiHRKa2bn5ty/v8+w3uUokp1bbEF6/5wOAfVCFxFk34zXKnOr2e3Ok5rD6AoaX6mAAG3mZBXCPvkAVNxcNOQyPv7p47IuS8H5VulVlLOUlrH+PNBwEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604299; c=relaxed/simple;
	bh=vHsTXZv5TyeF3HX5UW6hnKMqsavvFFm+POrGdkcd3fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkEFhQdotrMoZ21Cbn5XpY5n3XGEvhe1oQ4ym2KCjcfknk/pF7IhNSGwM0+9BPJS1uz/s0JowK4Pq3HA2pNRdcNTxdfO56bTFQp0bauj0igVIzGvlFRC8vXSWoH1L4ecEfLU/DKfLMGYCExf6CxYnlexauN8UsqXwS/3J5g7L+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkgJNwsY; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkgJNwsY"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b8f5e2ce5eso226956e87.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604296; x=1792209096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4lwgRqdIBm7UtaWzVpHkZBb7rvpL6UN+PLUcNwF8OI=;
        b=XkgJNwsYTpq7K+5h39+U0hDHyOZ4SFimOtAzhP+CUo1QcItqImglgcudINkIVs5tro
         bpIWpAE133tFXjgvA0csZrZlNERkjixBZ/VrmLjJEp8eduw3rvgHq6AVD3sKmlfkIIMe
         Ihh+oePUhNhpftxcVYU7IRWiMBoT0rtYcKAV3zzA9bYuQ53JoxqkCMd8t+piv5T1QQQr
         +Ftp6msTjzEvCQdhRKbZzNxGTK917rfXeBxXeAfAbz7VKPJ6VSrzyN1DpCOjNCXBH9I/
         pAOxsnLNtggjQqotKwA+5AkY4/nnR8IL4WUyxxZ85/4yFDDHIX+0Q53uVBFxoR0SRhHn
         zuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604296; x=1792209096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4lwgRqdIBm7UtaWzVpHkZBb7rvpL6UN+PLUcNwF8OI=;
        b=AbWNnxHWXbVCLuyZc4NTPDuiIG0VFFOX7m50iPQEqL78SQm9IFldoCj2m5/TnB77zO
         j1vLnu8cVoc3bKQFqgoG8faE9Cx6tWRnhbLdUrfhBZO/aBQSRXEwyg9W/amPXqo6/Srs
         kHhwPIoYU8J6feLThzWh7idk7HbczljbZFzbgDny/2nT2ptP4CHAf7MHSYNiESPuuwrh
         dZe83l3Z0/p7EQqnFmoAE7POH4w+Ok6BAiDWZM99LGMzjejawMv8JMbKFE9W5aRwoDFH
         72GIhbs9+ZhXiY8gYxq8oquOLBW638kE/1IWJHf1fOtYVujvORPKiX+fAVO6Qvm6pGgw
         jsiQ==
X-Gm-Message-State: AFq9FYK0WV/v5HU/GsgO7BiZXguGfipaHcMsnjTTRbeB/mRZEc6gWDA7
	2S05RI35u5KZ5rMtf99W1SlThU5wbVgnCmVucgLAm1fEc0mzSc2gKbzU8rAto8uwM3o=
X-Gm-Gg: AYBFou1jVFyBVIRcpDSM8mMZBTHkOyat1v2N5TYcZGC7+B3hlfnzdCWEf4uwnfatx6O
	ZNkJ5TXWuwQv7m6BVI9NMf3hnPg3hMo5BHvE6w10Kgntyhr4UAkJpYUU0nVU7jvr+o/+G8MlkH6
	RyAaBYTLRN2L0x//5xvnSRDzD2gFq0PjQGRUK5JanWHQu90SpKyp+A4eCxZsTdB5N2cLawyofKL
	A1+n/KAZXxUfNX4+tQWU6eCQEPU3jNf2dGNlmz2tSGXxlsDc2qm111wQIvedvNr+IIKSzVVHNU1
	uzhYMHM2cIAUuJh70vBx9oqlK3/KC4TKPLFWjUGuYrd+AY8i5d1O1RLqeZGGIZHoVDcDwrBrY0g
	VhZYuBSBlvjJ8VXkAiWJwInxy/wo2jjT/ahYz1ZtJW9MpkH0JvSwuMH7atdGda6PciJfHOMMdNb
	4+7lJ0aHQum/1F4mwfru8G/3ykBovCfW6eOehPv3cVCObVHDaXk6MyK3kvMM0AAA/oN5yTP1FDI
	ipV4YWBS7qzTsjmekSD/l68SRLpq9BqE6KBmVJWPlQ=
X-Received: by 2002:a05:6512:4011:b0:5bc:ddab:bbba with SMTP id 2adb3069b0e04-5bcde8bc77cmr1309405e87.38.1791604295488;
        Fri, 09 Oct 2026 20:51:35 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde9c924sm1161984e87.36.2026.10.09.20.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:51:33 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	netdev@vger.kernel.org
Subject: [PATCH 6.12.y 2/4] tools: ynl-gen: support limits using definitions
Date: Sat, 10 Oct 2026 06:51:14 +0300
Message-ID: <20261010035116.578385-3-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261010035116.578385-1-littlesmilingcloud@gmail.com>
References: <2026060807-egging-prune-a3ae@gregkh>
 <20261010035116.578385-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

commit fa796178e5eb0078a9a6c36f60fd6494cfc3f81d upstream.

Support using defines / constants in integer checks.
Carolina will need this for rate API extensions.

Reported-by: Carolina Jubran <cjubran@nvidia.com>
Link: https://lore.kernel.org/1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20250203215510.1288728-2-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Anton: the generator is tools/net/ynl/ynl-gen-c.py in 6.12.y. ]
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      | 5 +++--
 Documentation/netlink/genetlink-legacy.yaml | 5 +++--
 Documentation/netlink/genetlink.yaml        | 5 +++--
 tools/net/ynl/ynl-gen-c.py                  | 5 ++++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 4f803eaac6d8..12c60a6d88a7 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -14,9 +14,10 @@ $defs:
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 8db0e22fa72c..d2ee1199bdf2 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -14,9 +14,10 @@ $defs:
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index b036227b46f1..e43e50dba2e4 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -14,9 +14,10 @@ $defs:
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 00c05791a669..7e6b38ada78f 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -83,7 +83,7 @@ class Type(SpecAttr):
         if isinstance(value, int):
             return value
         if value in self.family.consts:
-            raise Exception("Resolving family constants not implemented, yet")
+            return self.family.consts[value]["value"]
         return limit_to_number(value)
 
     def get_limit_str(self, limit, default=None, suffix=''):
@@ -93,6 +93,9 @@ class Type(SpecAttr):
         if isinstance(value, int):
             return str(value) + suffix
         if value in self.family.consts:
+            const = self.family.consts[value]
+            if const.get('header'):
+                return c_upper(value)
             return c_upper(f"{self.family['name']}-{value}")
         return c_upper(value)
 
-- 
2.47.3

