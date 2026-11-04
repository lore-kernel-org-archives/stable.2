Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793785379;
	b=YQb3XSfxZREIHe+9Wu37uK14jwAqiVHtVPcH6LgPdsJlLbtbTpwbiV9UMer8ZnedMUTk
	 5jzheA5mY/7bxxA3d6xe544SaneYYq1WtM2Z47zgGrQPo+QM+ZRjIXeabK/Uw5pjtQex7
	 6RDi8mYndWb8uOc6t4n7F86OELEA7MNF9m6GRW3M+nex4e/Od58GKGlfylO6MHQv8i64H
	 iLzEm6J4k5Oub8qnCYdekQrvfLcpVKirY/s5+xUNvlVUMiNtwnTUBCIiHoq3fnxbatEkp
	 e8mII/GpjuEwG39IxGAoeEGmv5XL7AiuY+usbt4XO2g36aYqmoiX32LebmG6vLp7vLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785379;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=D58G5A1qEkQhPUDoNbIiyyOCK63BGppZGlmDWTU99/k=;
	b=rrO9NGK4olJ0id4Rld/YedvRjyffQ5G0HxPSfyA2Go2jWhsVYONsXUTPr8kvVC9z2QFn
	 7CtAXiQzWVirBZebBxmFQJ63emfMGV9Y/e9vuP+CXB+I1YTtOTfMkGTd3VxxQCSzacIxn
	 LyyZk4WdqrX+y7IgL9jBk7PFlaCA7diQCQDb30DMhlBAVYbmOPuSIOBqcRFTQQ0O6Lf1r
	 Fz4GJ2qZkdQcB4a4KI8Mbw5DwMmCln7NnzQ7D17drNkszvD6N5FaIVZevBJLYn6QcRiJc
	 TfXy4795nyrAs6Eo7rOzXV5CuRSbA9bGloeJa3VlH8UG5TJDxQygLgOvCMuwtok3VwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1X6SXZ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB041606A32E;
	Wed,  4 Nov 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1X6SXZ3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793785378;
	b=OuChjHfckH2FHGCRfPRSc7fFPcf68tz0j1T1QUUezuwY0FgYbAHuHmfNkjruHIRYApL/
	 6+SiVTz3jgP6NXofx5kdNBRfjTMmd/M7A0eMgE1qSqFtlk/oBJW+e7ohlgw/UgLWrjFp0
	 o1asQb30aPjfIqI9uzG90aiQ0wqT4Nv3PRB56RrgKUAY688Lt4/+Bcd5U3NgHYDTDM8Kt
	 nZgEkZhHlwpRVW0AXKXXhUsBDFnqnJ18wiCPletoAfTGXX3tp0MasT0Fh97WokC2rw8Li
	 PLvn50pBGImtf4WOkhUJ35pzfU4CXF/HbzmA3SrNnXSnZUsoLB9v+lXDtqYLcfzsudg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785378;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=D58G5A1qEkQhPUDoNbIiyyOCK63BGppZGlmDWTU99/k=;
	b=RtspqUluZmQi7vUDE05TWGDvWIFw6NXlOutm1RlBEMwgdZFmJ/3qXDbQlSi+B4ovyL2n
	 H3JQcA7DVOI8WUTcFYSH3oc/uHHQfQkMoCblkns0VYFZBxj1yfFGCJlHs9UxSicF7D83Q
	 jzYF4JexrSb8IGEfFN1DVviS28ejfEZH9SkWYsEjAswGQAQXPAagRgu3QgDsTinxyiJ7m
	 T79JbqzEDL83B0tZ//8aU1vMUXHcl+zlHpr911FpJsYsOfbQy7SI0XZMS9jq1KnbSxFtT
	 gmNLppO7p3CjkFNLj3ovqAsdoaKCODp51z5A/JcsJRz4EEgNndWn3xOeILUQ92HXm/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 792E71F00A02;
	Wed,  4 Nov 2026 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785378;
	bh=D58G5A1qEkQhPUDoNbIiyyOCK63BGppZGlmDWTU99/k=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=H1X6SXZ34LP/oy9wkNyOTVCZftNoaw3X4ftKpCZSBVVmhgEZuZF97tsIWeriA6az4
	 lSkOlMOjwZFoBhRIBxzAnEBAWE4w5WgpPHGhQPca/R+YWSrZZtDCJly4oWRnsnMmP6
	 7ifIfDcW+V8YA314kYeFb6yjg/X6TLm7LpXj6cEFxbGHyYwWOkBXa3vy9u45aFYL6+
	 AeCBNeQbGAeG+R6gV4RpgD8XwXabAEiQk3PsBzrraHP1u5e7wjlZXHU0AkpASifVCq
	 zkfl/nBxOQGPp9Abeeg3/mUJe/6ecliGBRkGOxpAGQcVrcnxx6ZoLhnIE9TD0MoL4E
	 dDed64saQqSjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CB4BB46D7D;
	Wed,  4 Nov 2026 09:42:56 +0000 (UTC)
From: Babis Danias via B4 Relay <devnull+b.danias.tutamail.com@kernel.org>
Subject: [PATCH 0/3] media: i2c: ov8856: Power management fixes
Date: Wed, 04 Nov 2026 11:42:46 +0200
Message-Id: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LQQqAIBBA0avErBtQK5GuEi0kp5pFKgoSiHdPW
 j4+v0KmxJRhHSokKpw5+A45DnDc1l+E7LpBCaWlFBOGYsyiMT548ksZLc32nM1hlHLQr5joD33
 a9tY+AyQ1TWEAAAA=
X-Change-ID: 20261103-ov8856-pm-fixes-ae4af48c822d
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Serin Yeh <serin.yeh@intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Babis Danias <b.danias@tutamail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793785376; l=3510;
 i=b.danias@tutamail.com; s=20261103; h=from:subject:message-id;
 bh=zPCKpa1WxT4M3EkE/P1dF4rtOobF4YsW7HE3y7Bx0Rc=;
 b=hlq/5LDnJZbHu6nvEaS/l2qT8VJ6qGkqmFa8ejkbU3Q/DFNYw6vmgWbc0SI6n9DrkKJvTYL64
 xpWvyvq4bm0DcBrrIMr6Is2jF0IPKg1zt+UuoLV3lAnapV3WN8l4Ipv
X-Developer-Key: i=b.danias@tutamail.com; a=ed25519;
 pk=6DWeigdk0D3JwBjwvmxo9RW8cG8S1Eku42cb9PP+ghk=
X-Endpoint-Received: by B4 Relay for b.danias@tutamail.com/20261103 with
 auth_id=1406
X-Original-From: Babis Danias <b.danias@tutamail.com>
Reply-To: b.danias@tutamail.com

Since commit 609a71568664 ("media: i2c: ov8856 : remove ACPI node
bypass mechanism") in v7.4-rc1, ov8856 also controls the sensor's power
on ACPI systems. Bringing up the rear camera of a Dell Latitude 7320
Detachable (OV8856 and a DW9714 VCM, behind a TPS68470 PMIC) on top of
that showed three power management bugs, fixed here:

1. remove() powers the sensor off even when runtime PM already has,
   giving unbalanced regulator and clock disables. This also affects
   devicetree systems, since 2020.

2. probe() registers the sub-device before enabling runtime PM, so
   ipu-bridge can't runtime-resume the sensor to instantiate its VCM
   (-EACCES).

3. With the VCM driver bound, the sensor stays powered through system
   suspend: the VCM's device link stops the sensor from using
   direct-complete, acpi_subsys_suspend() runtime-resumes it, and ov8856
   has no system sleep callbacks to power it off again.

Patches 1 and 2 fix older bugs, so they carry Cc: stable. Patch 3 does
too, because 609a71568664 is tagged for stable: the bug it brings in
will reach stable kernels with it.

Testing

Tested on a Dell Latitude 7320 Detachable (BIOS 1.39.0) running the
Fedora rawhide kernel 7.4.0-0.rc1.13.fc46, with these patches built out
of tree. The board also needs TPS68470 board data that isn't upstream
yet: the front camera entry from Sahan Nissanka's series adding board
data for the Dell 7320 Detachable, plus the rear sensor's supplies,
reset GPIO and VCM supply, which I plan to post once I've agreed it with
him. With that:

- unbinding and rebinding the sensor gives no warnings (before: the
  warnings quoted in patch 1, on every unbind);
- the VCM is instantiated, and the dw9714 driver binds and moves the
  lens (before: the -EACCES error quoted in patch 2, on every bind);
- in 20 s of s2idle with the camera idle, regulator and clock traces
  show the sensor powered for about 12 ms at suspend entry, then off
  (before: on for the whole suspend);
- streaming with libcamera's cam works at 1640x1232 and 3264x2448.

The "before" results, and the logs quoted in the patches, come from
Fedora's 7.2.15 kernel with 609a71568664 backported, where these
patches also passed the same tests. On v7.4-rc1 I tested with the
patches applied only. checkpatch.pl --strict is clean, and each patch
builds without warnings with W=1. I haven't run sparse or smatch.

AI assistance

I'm not a kernel developer. I did this work with the help of an AI
assistant, Claude Opus 5.5, in one long session. I asked it to help me
get the rear camera working, one step at a time. It read the kernel
code, proposed each test, analysed the logs and traces I sent back,
found the commits the Fixes: tags point to, ran the build and checkpatch
checks, and wrote all three patches, their commit messages and this
cover letter. I ran every test on the hardware and reviewed each change
line by line before signing off.

---
Babis Danias (3):
      media: i2c: ov8856: Don't power off a suspended sensor in remove()
      media: i2c: ov8856: Enable runtime PM before registering the sub-device
      media: i2c: ov8856: Power off the sensor during system suspend

 drivers/media/i2c/ov8856.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-ov8856-pm-fixes-ae4af48c822d

Best regards,
-- 
Babis Danias <b.danias@tutamail.com>


