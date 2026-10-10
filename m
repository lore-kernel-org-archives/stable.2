Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8EC3B4E9A
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604301; cv=none; b=Jbnd0K3lLmlCZhFQ1LOg6YV+hnkBP00Xq/b22Aaz38HPx9zVRyCkRFkdm6qQDQXpFNI0ofoO8B5TGyTwj2ya88oY8ZtZOouQaCsOHuOAntaU3SxVBF0WRfdvl0MWr/IDmlmzQ/bdHo32IT6oKE0wfv7VGSxx004KAKeZcXz9/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604301; c=relaxed/simple;
	bh=8/vp+Uh9lf8asnHdZVo+B2pmjMLDnsodUn5dgmwbS5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/9VcfnT3h5IlleI4zyD25cn9djDg3lF+NdIZQbNjjJ3BXNPZThpPizh9XZ6qkXp0HnTj5P7QhmsVZ7XHCEsHGNn+uWEfyb0ka80izTTA1T0VAmhtqQdqgmoWxZRzM2v7o954xxt/iLtu4yazrqJz2y2m6MVO+ostx/MY3MqKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiczssT4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiczssT4"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba37877490so247985e87.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604298; x=1792209098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miiJUjBn7YGDRW7Q8CA+7JpD/iOrNnpqOu38b4xVhnw=;
        b=JiczssT4F+i/qbY/P8OnK/z6g9A3j2R5gQViNQ8qnj1bXEipGRw3Z4c1yR9E10E1s2
         tbF2oXoZ/0/DVTnh3RoeAZiH6F0BNR5Gt9Ho41T5QcJzfoT2Hh7i4F2LU2TlJVQsW1s9
         ox0S2qfyMXLNAXB53UfG4mJ7ZbgtZfOwO9ZrNTZk+ig4Q9m0DwcwpO5JzOFWRslf0PrI
         RdMMDjkH+EIRQG98yIneTFop8u554DQ5C0HDAIyfWNkYJ0Z04PKa4Ry9tUdTcDvNI/EU
         BobZA4v+1HeCEYdO1ezS5r7WsDzd0u0+Q6FI73CgBCmzdP7zuCk01AUtdbZ9OU+DMP1n
         YtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604298; x=1792209098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=miiJUjBn7YGDRW7Q8CA+7JpD/iOrNnpqOu38b4xVhnw=;
        b=wIk/n1DdaytgPKAKnwQxH4cTLMPcaFGnpmm27ptcKwC944xt71H+K5wDF8hVdqbcGF
         KMu8gY/tMRMxk4RDJvCgXNWfJP9AcenBc6/vgOSRssI8ypJN74hRe55U7QBq7Wr25Lsi
         iw/YsHCFi4HWBYVPVSlzFdjBsJJRhVzNCf9bRrMMxHRbu++D27Z2BNOKdrhEaTsTR7Kf
         rf9JDdgSfNisw1pqsQJmeSkydV+u2nA1YsyURL5w0B3BDLgqVSTGM+jh3m1Gec5mNTxD
         1J9CZeUPz7VeivUX1aK5WqRVRe16OF5GD0nZNcR3bbSLy3gPOYu1GVqGRBvlLGetfo70
         BIwg==
X-Gm-Message-State: AFq9FYJ6RP8HIK/RDlH7snSxBU8CrSAeCIFhD9Tg0Yu7qthKMFsFknuG
	DLXYoK/CBOIxspzLBG5ZDT/ImvCZE44ye1yC0Zg0PZGhJCYgjQ0HuJ6tqmdmRitdNbk=
X-Gm-Gg: AYBFou1JQpDB2lBY3HLLXHzY80hNWs793xhtEaHkQ4w6U08yIX0jnwm0bGTUsPUTe4U
	4inDWQ4FiJtjZCKybc6M5ldvo5VuOb8lgitdPjTZXovAUrKLvlE0kGFoaANmg8NtO2JpHDIh4Bx
	waH156Zn1vJ4Sr4A6Frv2TbeuEBlUWCkAn3Qgx1avEImpAjo+7WX7K8/UXLd+VLtwBCR1oDytqD
	b2St1Q6t9Qzu5zbUO4Uubu3Fpq2oVYyIvBnY91ANG83gqxlzyD5nBTNXe3dWpVNhkDQFLJc7/dw
	BFM23LM7gn4ASoP+s+W7Gw6m54JSLnU1IZeaTLgOnH1//E8UCGCfJ+DIg9nUUuXcZmXwb0DooW8
	D6epe//pUjZXheDsRil0JyjaceTKO1WBS+U2gKPSOPHYjq4feKKSjSzqO62Rtq4Rn3bIzwlQXyI
	OkuVuvg9P6feHlkCGQQnxyfMbxXHbkih2/ZRtMSuD5cEDhODihJNYJF+gN5P3Ik3swhVI97JX+2
	c4G/0FQgAIh6vJinSL99SjFoHXV1HpHkqZEQtUcwyA=
X-Received: by 2002:ac2:4f0d:0:b0:5bc:c656:3b42 with SMTP id 2adb3069b0e04-5bcebbe1164mr29051e87.19.1791604297734;
        Fri, 09 Oct 2026 20:51:37 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde9c924sm1161984e87.36.2026.10.09.20.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:51:36 -0700 (PDT)
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
Subject: [PATCH 6.12.y 3/4] tools: ynl: add scope qualifier for definitions
Date: Sat, 10 Oct 2026 06:51:15 +0300
Message-ID: <20261010035116.578385-4-littlesmilingcloud@gmail.com>
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

commit fbf5df34a4dbcd09d433dd4f0916bf9b2ddb16de upstream.

Using definitions in kernel policies is awkward right now.
On one hand we want defines for max values and such.
On the other we don't have a way of adding kernel-only defines.
Adding unnecessary defines to uAPI is a bad idea, we won't
be able to delete them. And when it comes to policy user
space should just query it via the policy dump, not use
hard coded defines.

Add a "scope" property to definitions, which will let us tell
the codegen that a definition is for kernel use only. Support
following values:
  - uapi: render into the uAPI header (default, today's behavior)
  - kernel: render to kernel header only
  - user: same as kernel but for the user-side generated header

Definitions may have a header property (definition is "external",
provided by existing header). Extend the scope to headers, too.
If definition has both scope and header properties we will only
generate the includes in the right scope.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20260510192904.3987113-8-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Anton: the generator is tools/net/ynl/ynl-gen-c.py in 6.12.y and its
  context differs, the hunks were applied by hand without changes.
  6.12.y lacks commit 3ff5258b9781 ("tools: ynl-gen: allow overriding
  name-prefix for constants"), so render_uapi() ignores name-prefix of
  constants while render_scoped_consts() honours it, as upstream does.
  No spec in 6.12.y has a constant with name-prefix. ]
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      |  9 ++++++
 Documentation/netlink/genetlink-legacy.yaml |  9 ++++++
 Documentation/netlink/genetlink.yaml        |  9 ++++++
 Documentation/netlink/netlink-raw.yaml      |  9 ++++++
 tools/net/ynl/ynl-gen-c.py                  | 31 +++++++++++++++++++--
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 12c60a6d88a7..228b6bacd3d0 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -69,6 +69,15 @@ properties:
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags ]
         doc:
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index d2ee1199bdf2..c9f1b8120912 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -80,6 +80,15 @@ properties:
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags, struct ] # Trim
         doc:
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index e43e50dba2e4..179e6000c0a2 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -52,6 +52,15 @@ properties:
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags ]
         doc:
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 914aa1c0a273..d8ae7f7365b0 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -75,6 +75,15 @@ properties:
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags, struct ] # Trim
         doc:
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 7e6b38ada78f..07786d7e9b0b 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2432,6 +2432,8 @@ def render_uapi(family, cw):
     for const in family['definitions']:
         if const.get('header'):
             continue
+        if const.get('scope', 'uapi') != 'uapi':
+            continue
 
         if const['type'] != 'const':
             cw.writes_defines(defines)
@@ -2565,6 +2567,25 @@ def render_uapi(family, cw):
     cw.p(f'#endif /* {hdr_prot} */')
 
 
+def render_scoped_consts(family, cw, scope):
+    defines = []
+    for const in family['definitions']:
+        if const['type'] != 'const':
+            continue
+        if const.get('header'):
+            continue
+        if const.get('scope') != scope:
+            continue
+        name_pfx = const.get('name-prefix', f"{family.ident_name}-")
+        defines.append([
+            c_upper(family.get('c-define-name',
+                               f"{name_pfx}{const['name']}")),
+            const['value']])
+    if defines:
+        cw.writes_defines(defines)
+        cw.nl()
+
+
 def _render_user_ntf_entry(ri, op):
     ri.cw.block_start(line=f"[{op.enum_name}] = ")
     ri.cw.p(f".alloc_sz\t= sizeof({type_name(ri, 'event')}),")
@@ -2718,8 +2739,12 @@ def main():
             cw.p('#include "ynl.h"')
         headers = [parsed.uapi_header]
     for definition in parsed['definitions']:
-        if 'header' in definition:
-            headers.append(definition['header'])
+        if 'header' not in definition:
+            continue
+        scope = definition.get('scope', 'uapi')
+        if scope != 'uapi' and scope != args.mode:
+            continue
+        headers.append(definition['header'])
     for one in headers:
         cw.p(f"#include <{one}>")
     cw.nl()
@@ -2731,6 +2756,7 @@ def main():
             for one in args.user_header:
                 cw.p(f'#include "{one}"')
         else:
+            render_scoped_consts(parsed, cw, 'user')
             cw.p('struct ynl_sock;')
             cw.nl()
             render_user_family(parsed, cw, True)
@@ -2738,6 +2764,7 @@ def main():
 
     if args.mode == "kernel":
         if args.header:
+            render_scoped_consts(parsed, cw, 'kernel')
             for _, struct in sorted(parsed.pure_nested_structs.items()):
                 if struct.request:
                     cw.p('/* Common nested types */')
-- 
2.47.3

