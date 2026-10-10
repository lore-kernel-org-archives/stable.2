Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAB279DC2
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604297; cv=none; b=mlS0mRo/xhcapQzdlejxU33d0KATO6Fuo5gaQ80dyS5E5PJWjX/7P5/Ln5e1iKs8b8JbMk2g1TAJOejR1zmLtGLQM06/zKgCt3zM7I99EmVMZWYpvb568Rbct4PMvQeLn3oLe3DUKkPpvz1RW/C+S/QyCbCZGIk2f5WTOD7i+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604297; c=relaxed/simple;
	bh=yJPqhsn1mgTJOQgFPJ3moH4bSVzQAF0ZE6DOkKTfC+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPA/iNnrbbmPo7+XZMNIJ0disD8qDQacQFds8Zxi/OeRH/FIJZ38NgcJVJQ3GYGttdJ23aNIw3DNE44PbySEBopwXdVQef8wc5KpEYx70ENxXZOk3fKk4ZwmTZ8ROaBG6AJ04cfAZ96e+qh/5xv7kinvdPTwSahYXuSfZxtekGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ld0yih3L; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld0yih3L"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so188112e87.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604293; x=1792209093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9Bu6nhzG4Glx+4j+FmgXHdHD3BZ6WNoxK+m45oyaJE=;
        b=Ld0yih3LibKOeGxOQOcpzhvrsHKMI/uVddQrTrdHxbU4yHY2ThYLHKBFl49MyhBR1i
         2KFPFTaw6omqTWd8YymVuu2+ww9pVTGERW6vlIw2MTcmgX9fSwrUvk9JX2itYl/zxIur
         ns9A1/xt9fRwMe9FI0W42eag70yjUv4w1wHBlpeoAX7UVYDqncEcdT91hNj7KIf/okhp
         jXkvCwWMXyzxXRZmaj1hdFmDeJaPPhvXkI48nHr5Q/ZFp3/rWEurSmhOD4rYXmJhuNO0
         jrngTEIyg6JIsFdIdY/0xufc+LxTT70STdxvJVSFRJhrqePFT9dmSSMvyyYP3zs424Q+
         3PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604293; x=1792209093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E9Bu6nhzG4Glx+4j+FmgXHdHD3BZ6WNoxK+m45oyaJE=;
        b=Bk10t91YZ64AhMiGz8Z0IV4QfF6eU43ZflECjJ4VQw7to4poPBieGaSKoB7ad77a+N
         XcKKrwEyMUUAeCPlJcgzJwd6R6fXBF2SYoC0xvDvI+f6irUfBJK9m/UbCTDHo8ax69Nh
         7Ba5y6XroAjAgfswvaLKs8utQQc813Oi55EV7yK12MUxcrcWgJw1p8mSnsNot7f+kulH
         KKNL21055OzNtKQmwccYsDQbpkc2xDfGVFb6Z2w6QjsqOiDdqGKJ23Okb9TYTS3HMb9v
         e7lOXEziTI+GkbprGD7TROpJm/lAY7r1a5SLuj0GkQbcxl8Vj/F9ptMPIIHkzEeFQncU
         M0Vw==
X-Gm-Message-State: AFq9FYIWn+RxnDXeMGM4axywISBymBuWqLfO8jtzt4PRD4JkpcgBTKCD
	1x2U8tSwzlMbmkwbEOdDDHWUsD+Qo047HalatdTxk82W91kw57Q0PFW3PCuy+8g2RVY=
X-Gm-Gg: AYBFou126TauQMy6MuA5B3H3liOJnE3+VJarMmbHhAS+oqmUACzLzkSrxN/Z2LNYes1
	/KO9eR2n/i3cVnye78N4XXGLe8ep4+HXpeQEXXJb1w27+4sIvRWqRUBNu6p4OqPbEyhTRnTkJq3
	22D2KZSnoPuZ20lVGiuSzPEE9viorF0XfgiBZEQVYJyYhubtb2pDfxJzLoln6SBm9hzHwTPTTK+
	JbUHoPEMuvZoGWyTzNxNZ5EfTj1NFGkA2AgqnZWGpUI900JsPiDfMn2q0kujSb3sjMEvyKrlgmo
	V+zBz4JVdk5qGzIH7X4gw7IHIf32UoxfBqCWNGeyzx1ugODtvgEHuNfnI7CU41Pyp439VjTA09U
	tHWmLoERs0903zYVR1JBiVvxeOqaGNEv6RJKtfLGNsYBxabgNr8dQCUdHHnLfQHj/9faIiAHumT
	L2vr54MkZ2hRMS1IhpcPAE0G+VPy7vVfWLD6Z9Lfse7aGcD3elFeW5wR8fpfPheKtMhy6N9LgIf
	UBzvZNySigeiUHrH2TbJw8MRvCYuSP1HNmBJI6cnziGrMDGRCPg4w==
X-Received: by 2002:a05:6512:2c8b:b0:5bc:b728:342 with SMTP id 2adb3069b0e04-5bcde6cfabbmr1579136e87.34.1791604293059;
        Fri, 09 Oct 2026 20:51:33 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde9c924sm1161984e87.36.2026.10.09.20.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:51:30 -0700 (PDT)
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
Subject: [PATCH 6.12.y 1/4] tools: ynl-gen: use names of constants in generated limits
Date: Sat, 10 Oct 2026 06:51:13 +0300
Message-ID: <20261010035116.578385-2-littlesmilingcloud@gmail.com>
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

commit bcbbfaa2612d7d0e9c3eafade5f6e93c3672f34f upstream.

YNL specs can use string expressions for limits, like s32-min
or u16-max. We convert all of those into their numeric values
when generating the code, which isn't always helpful. Try to
retain the string representations in the output. Any sort of
calculations still need the integers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Link: https://patch.msgid.link/20241010151248.2049755-1-kuba@kernel.org
[pabeni@redhat.com: regenerated netdev-genl-gen.c]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Anton: 6.12.y has the older TypeBinary._attr_policy(), switch its
  get_limit() calls to get_limit_str() there. Drop the
  netdev_a_napi_defer_hard_irqs_range hunk from netdev-genl-gen.c,
  that range does not exist in 6.12.y. The file now matches what
  ynl-gen-c.py generates. ]
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/core/netdev-genl-gen.c |  4 ++--
 tools/net/ynl/ynl-gen-c.py | 36 +++++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8614988fc67b..b54f5948555f 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -14,12 +14,12 @@
 /* Integer value ranges */
 static const struct netlink_range_validation netdev_a_page_pool_id_range = {
 	.min	= 1ULL,
-	.max	= 4294967295ULL,
+	.max	= U32_MAX,
 };
 
 static const struct netlink_range_validation netdev_a_page_pool_ifindex_range = {
 	.min	= 1ULL,
-	.max	= 2147483647ULL,
+	.max	= S32_MAX,
 };
 
 /* Common nested types */
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index c78f1c1bca75..00c05791a669 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -80,11 +80,21 @@ class Type(SpecAttr):
         value = self.checks.get(limit, default)
         if value is None:
             return value
-        elif value in self.family.consts:
+        if isinstance(value, int):
+            return value
+        if value in self.family.consts:
+            raise Exception("Resolving family constants not implemented, yet")
+        return limit_to_number(value)
+
+    def get_limit_str(self, limit, default=None, suffix=''):
+        value = self.checks.get(limit, default)
+        if value is None:
+            return ''
+        if isinstance(value, int):
+            return str(value) + suffix
+        if value in self.family.consts:
             return c_upper(f"{self.family['name']}-{value}")
-        if not isinstance(value, int):
-            value = limit_to_number(value)
-        return value
+        return c_upper(value)
 
     def resolve(self):
         if 'name-prefix' in self.attr:
@@ -358,11 +368,11 @@ class TypeScalar(Type):
         elif 'full-range' in self.checks:
             return f"NLA_POLICY_FULL_RANGE({policy}, &{c_lower(self.enum_name)}_range)"
         elif 'range' in self.checks:
-            return f"NLA_POLICY_RANGE({policy}, {self.get_limit('min')}, {self.get_limit('max')})"
+            return f"NLA_POLICY_RANGE({policy}, {self.get_limit_str('min')}, {self.get_limit_str('max')})"
         elif 'min' in self.checks:
-            return f"NLA_POLICY_MIN({policy}, {self.get_limit('min')})"
+            return f"NLA_POLICY_MIN({policy}, {self.get_limit_str('min')})"
         elif 'max' in self.checks:
-            return f"NLA_POLICY_MAX({policy}, {self.get_limit('max')})"
+            return f"NLA_POLICY_MAX({policy}, {self.get_limit_str('max')})"
         return super()._attr_policy(policy)
 
     def _attr_typol(self):
@@ -413,11 +423,11 @@ class TypeString(Type):
 
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
-            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
+            mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         else:
             mem = '{ .type = ' + policy
             if 'max-len' in self.checks:
-                mem += ', .len = ' + str(self.get_limit('max-len'))
+                mem += ', .len = ' + self.get_limit_str('max-len')
             mem += ', }'
         return mem
 
@@ -465,11 +475,11 @@ class TypeBinary(Type):
 
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
-            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
+            mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         else:
             mem = '{ '
             if len(self.checks) == 1 and 'min-len' in self.checks:
-                mem += '.len = ' + str(self.get_limit('min-len'))
+                mem += '.len = ' + self.get_limit_str('min-len')
             elif len(self.checks) == 0:
                 mem += '.type = NLA_BINARY'
             else:
@@ -2161,9 +2171,9 @@ def print_kernel_policy_ranges(family, cw):
             cw.block_start(line=f'static const struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
             members = []
             if 'min' in attr.checks:
-                members.append(('min', str(attr.get_limit('min')) + suffix))
+                members.append(('min', attr.get_limit_str('min', suffix=suffix)))
             if 'max' in attr.checks:
-                members.append(('max', str(attr.get_limit('max')) + suffix))
+                members.append(('max', attr.get_limit_str('max', suffix=suffix)))
             cw.write_struct_init(members)
             cw.block_end(line=';')
             cw.nl()
-- 
2.47.3

