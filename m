Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792869444;
	b=ElazikQXsGzN/A8CbWpodD6pJCfQb1JuZs2LfVpYvMAJ1pFWQSnxXSCURdw81yTsAg+8
	 Hdb+tGbpCqutdHp3IGmTssMAQ3rYTczBlWFpjw1I4l4V1R7fEZeZSJ7OhMr++dIuMPjwm
	 spAsdcYAEISzM0/FifFEVXClkOjaWWs4MqSsym9hhs0gjpnovieyJl/DMyaT8NJ6oIMyF
	 62A/BC1hLh3MMf64NwQL27HtaF7y43EBaZNp/m170GG+PWmy4qXr3D2SEEAFltaCBSo2b
	 y4l+K80OFXh7S5spsOGWvtgNFSiDE80eTeJRmecLQEDLGXqxuODxznrz4SceaqpPeJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792869444;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6squhMuLYy2EBe97sncljMe+XQj820AsZFCagkA1eUU=;
	b=dE9e6/cSGuWRonEpQtwaioU4DVNftKRR0zYPV4I8gbJZzjkIAxFSzWZkgBA0/+gPsXuN
	 V/E7+wcEotHwiwiqfzOTGDbEwq0N4LkJtdw8pHFfWRnTajLbrireXJWmlmlefxQfAWAZu
	 5hD998l/qFEbQA3Z0rJjfXBhoZ+sxBI84Zf9C9D/luvPMEdnmuUFsXLSbg0D9jvLebtfO
	 hUfpwhagfao/CydVuyfZSIp/lXFu9hd2gYyhnTZaCRxVdY3yftnirGG5nm5REfQO0D60f
	 Q7lbGPA7Yu1Z82DNtjRytUCutFAvlq0UOv1jJ8SF1i2A9XskjeBrx84gtFayqhnmFrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQJS0dYt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA3606A31D;
	Sat, 24 Oct 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQJS0dYt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792869443;
	b=ejyBi7BCR9IvumHdjz/xTzp6mrnjLTMzIb5M/OSAMvPWlHiqDm6QdqiHjHAO+R6xZRSA
	 2DQM2skUjM5sp3NDhhKGYFb4h3+Z1cy1tNVmJe9aqMxQpczeqmc1omwKQHKjnmjuc8OQK
	 wuR5+9SzOLBSSc/Iovj8UCEqYV0CBoOsrPsX3H/g8SxapOCe/hvBzTEvUjnzrjOl7UFV2
	 ukQwCarzSYjbh6aCOX4C1VnBoccKKQp5TGYm/BbLH+zoRougf66wL2OfRCgi4zb85VXxC
	 PxAVdAJ/l8lxuhn0txLl98UI4k387jrMiAVBoXqaRfOQAH5Icgufn8CuEMCr1MIPQOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792869443;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6squhMuLYy2EBe97sncljMe+XQj820AsZFCagkA1eUU=;
	b=ordz9RgJYVrABS5ifnfrVoBo3yNUXqCD71crnSlzevOUF2QmPudOafci4ii5PTMlgBsN
	 b39f6i2vfl1U18mvNpDSfpr2BgWCte6cK7ykA5C/fDK4S4XpdSpiLo3sdkgADYtqPJhS2
	 mP6fyvn0tVaZhZK/5rm3Hk0AHR1eyCE92Nx2tz6cyvRwB1o090ytPqA+7rcLBxJejM+xm
	 FnuNWQUEpWyWarTz/rNH/N6Upp6NyvmNmfa6BBkQ+N7rt9AIKzNn6KH9JZxjNAThIZxtb
	 XcPOYEKqTPdP0IkzsSc7GTm6ivwY++yUe2ZkgrInqgLDotI5rvmKx093YNcL4LmAg2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C64131F01825;
	Sat, 24 Oct 2026 19:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792869443;
	bh=6squhMuLYy2EBe97sncljMe+XQj820AsZFCagkA1eUU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=BQJS0dYtdWk/W/5cmHgebHnvejkaRYNc1bNWmJZ8gnyQBAnlyduE70fRvDlkCzcHA
	 hUGqUZzJvwtrguuTRzSoCv83RVgyekmsYNac36fC5D7HuokwQvUJpzxPS5fwn6X36N
	 i8j+5jSSmHc1dzFfYFUUeyB2IBx9/ClgrX99O5EnGYcSmN7p1pnDQsbUfjVqTth34a
	 PUU4hQ4zYy0A+X2KmzEHOU+lZAkZuOVOpi6UJyrKVMfUTJuLgOUbMi0Wktk1iLr2PD
	 8/DhA8oQuvMZD1RuHnnCSpjPA6gxQm8pKd7cZoIHK1ai+5r4oivcvBOggqgVy2RIR3
	 1LtbLB4m57DUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 25D364487C;
	Sat, 24 Oct 2026 19:17:22 +0000 (UTC)
From: Moe Mahhouk via B4 Relay <devnull+moe.flashbots.net@kernel.org>
Subject: [PATCH v3 0/2] virt: tdx-guest: Fix and speed up the wait for a
 Quote
Date: Sat, 24 Oct 2026 19:17:11 +0000
Message-Id: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
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
X-B4-Tracking: v=1; b=H4sIADcE3WoC/4WNyw6CMBQFf4V07TVtkUdd+R/GBS23UEMotoVgC
 P8uxY0xMS4nOWdmIR6dQU/OyUIcTsYb22+QHhKi2qpvEEy9MeGU54xyBqGeoRnRB3iMNiAMtuu
 A6kJqlQlBqSTbdXCozbxrr7c3+1HeUYXoiovW+GDdc+9OLO7+JCYGDAQTVVmUjKOSF91VvpU2+
 GOPgcTMxD9F/IeIA4UiO6UqR8nrNP8Wrev6Am58KRIXAQAA
X-Change-ID: 20261021-tdx-guest-quote-poll-0f7bfc59900b
To: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Dan Williams <djbw@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Moe Mahhouk <moe@flashbots.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792869441; l=3495;
 i=moe@flashbots.net; s=20261021; h=from:subject:message-id;
 bh=IVZw3pNNxHAWxQnRDT0sxY97XzAFqgNzzTc6OB604NA=;
 b=svVqwMwL4TZHeYuxIYWsQfzBZK5iWYLkS6AsuKDTLZAbTWAoChWFT3RbN/TltKSXFlbSU27H5
 iOn6x5KEkWIDm4tISI8HdCkcFnCyvYI5MZtxsb8LRW6OV97rqxg5qxB
X-Developer-Key: i=moe@flashbots.net; a=ed25519;
 pk=hJTKfjLno/YESrpxMIKDJk34GM+/8Tol+24XK2b4xf0=
X-Endpoint-Received: by B4 Relay for moe@flashbots.net/20261021 with
 auth_id=1259
X-Original-From: Moe Mahhouk <moe@flashbots.net>
Reply-To: moe@flashbots.net

Getting a TDX Quote takes at least one second, because
wait_for_quote_completion() sleeps a full second before each status
check, while a local Quote Generation Service answers in a few
milliseconds. Patch 2 polls with an exponential backoff instead.

In v1, Kiryl noticed that the same loop gets a real timeout wrong.
Patch 1 fixes that on its own, so that it can be backported; patch 2
then replaces the loop.

The GHCI SetupEventNotifyInterrupt mechanism would avoid polling
altogether, but it relies on the VMM implementing that service. This
series keeps the existing polling model, which works with any VMM.

Jun Miao posted a patch for the same latency in September [1]. It polls
every 2 ms with read_poll_timeout() and lowers the timeout to 1 s, and
has had no review so far. This series keeps the 30 s timeout and backs
off instead of polling at a fixed rate. Patch 1 is needed for released
kernels either way.

[1] https://lore.kernel.org/all/20260917102202.750895-1-jun.miao@intel.com/

Testing on mainline a804c5742 in a TDX guest (KVM host v7.0, QEMU
11.1.2, TDX module 1.5.34, Intel QGS, guest HZ=250), through
configfs-tsm:
- Latency, 40 back-to-back Quotes: 1021-1024 ms each before, 6-12 ms
  (median 8 ms) with the series. msleep_interruptible() rounds up to
  jiffies; v1's usleep_range() got 2-3 ms.
- Timeout, with a QGS socket that accepts and never answers. QEMU fails
  such a request itself after 30 s, so for this test getquote_timeout
  was lowered to 5 s: without patch 1 the request fails with -EIO and
  no message, with it -ETIMEDOUT and "GetQuote request timedout". With
  the default 30 s and the old loop, QEMU's error lands in the last
  sleep and is reported as -ETIMEDOUT, the second case in patch 1.
- SIGTERM to a reader waiting on such a request: it exits within one
  10 ms tick of /proc/uptime with the series, as before it; with v1 it
  took 110 ms.
- W=1 build of drivers/virt/coco/tdx-guest/ and checkpatch.pl --strict
  are clean.

The patches and this cover letter were written with an AI coding
assistant, Claude (Claude Code, model Claude Opus 5.5), which also ran
the tests.

---
Changes in v3:
- Patch 1: Cc stable (Sathyanarayanan)
- Patch 2: say in the comment and the changelog that
  msleep_interruptible() rounds up to whole jiffies, so at HZ=250 the
  first steps are one tick each (Sathyanarayanan). No code change.
- Collected Reviewed-by tags (Kiryl, Sathyanarayanan)
- Link to v2: https://patch.msgid.link/20261022-tdx-guest-quote-poll-v2-0-7543c6eb2d36@flashbots.net

Changes in v2:
- New patch 1: fix the timeout detection on its own, for backporting
  (Kiryl)
- Patch 2: msleep_interruptible() with a 1-100 ms backoff instead of
  usleep_range(), which sleeps uninterruptibly (Kiryl)
- Patch 2: secs_to_jiffies() for the deadline
- Test and tool notes moved from the changelog to this cover letter
  (Kiryl)
- Link to v1: https://patch.msgid.link/20261021-tdx-guest-quote-poll-v1-1-919a87812ecb@flashbots.net

---
Moe Mahhouk (2):
      virt: tdx-guest: Fix timeout detection in wait_for_quote_completion()
      virt: tdx-guest: Poll Quote status with exponential backoff

 drivers/virt/coco/tdx-guest/tdx-guest.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261021-tdx-guest-quote-poll-0f7bfc59900b

Best regards,
--  
Moe Mahhouk <moe@flashbots.net>


