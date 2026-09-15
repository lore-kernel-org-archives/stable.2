Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1D1473C65;
	Tue, 15 Sep 2026 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467759; cv=none; b=n8z45+9L/e8qJyTPciOTlMdcRlmxOSl4YoW4G1B5f1mfJlzchmX7iJ5kh30js6jC+iFIa9W7cVAWCqjY5JhEruQY70is1sueYxIfa14G21f36LV8mKOO5p9xCNuDKpt52CTvcz4r+YCR08+QOrCknE/evKOzXnD8lnZUmM9gq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467759; c=relaxed/simple;
	bh=hiV/G4OIpnMoj2ZHNIQVD88dPVpXmhWYk6cNSZeoQ5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PeUefo6FArANkaaVniKIqerP8lVvCPT8VvI85hVPZPjSRvVkC/Oj/2powO0dVDqm+RpK/pOpTXQiiZU/CeCXBiZUXbgbuS1Ba+N+0h2+fqfP5JbrwpLYPdjN3neTJEoeLHD7Yce1qN89WN91RDzZbUYJ+VzfKfdSXFGTi/JAmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfIkvoHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfIkvoHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5D31F000FF;
	Tue, 15 Sep 2026 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789467757;
	bh=4wyAN/shpVet1S7FZt5snhxeSjOLcT30h3RcCDyECW8=;
	h=From:Subject:Date:To:Cc;
	b=ZfIkvoHuyoWfLphJF9Ux/OT4dkN+zFZQjaLlXaS7GZfJGOmGzf8lg8h+Y74WUt5/e
	 /BiOGflsUMFI0uhczf1E+CDDNEGIpg2rwutvXVQIErFAYQXheRrIn4OsVfapPO/EFQ
	 WAfh6gZSe10k4LqAeeZbC+VmbTj7mdl9Hac/TWj+QeSqOOxeiSOxH2zLnvOmRHt/PN
	 cpE30FHNm/x+Em13Jvt760nDmFNjxbpiIQ/ntoccCY02TX5A3PNPXT/WuBEtn7odIJ
	 /p1ejqDKWjRRK5WrmqLZF7f9snnNTXxYf1MpylBkFfcQCj6IkjV0KYuXfggss/vOIh
	 d5xojTxLi9CIA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/6] coredump & signals: an impossible affair
Date: Tue, 15 Sep 2026 12:22:15 +0200
Message-Id: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMSw7CMAwFr1J5jaO0EpByFcQiH4cGRFrZFJCq3
 p2kiOXYb2YBIU4kcGoWYHolSWMu0O4a8IPNV8IUCkOnu4Pu2z2+R76jH5nC/Jgwpg8JUoi98UZ
 HOhoo5sS0PYp4vvxYZncj/6ypunBWCB3b7Id6qlH1j6rNVXUC6/oFe3/HSqIAAAA=
X-Change-ID: 20260915-work-coredump-fixes-edf98c80fe78
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hiV/G4OIpnMoj2ZHNIQVD88dPVpXmhWYk6cNSZeoQ5Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStlMmI2DN5t9OqdXZvGF6dytFdOf3BmmtVlav9lepWN
 n7Y2PHjVkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBENO4yMpwremp0rWHm9Fim
 ry3/o27Z/L70YHK4ftcczW3PkudM2HyAkaHrn9zNuxfNMva9e8Mcdj2V3TZQIfnoEu2jE7jKGPJ
 ZvzEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

I asked Chris (Mason) to look at some of the coredump code with kres and
he found a couple of things. Some of them I had already found and fixed
but there's some good stuff in here.

@Jens, please take a look whether the io_uring fix makes sense. That
kres thing added some patches but I found them all not very good and so
came up with other fixes mostly.

@Oleg, I'm unsure about the freezer and coredump interaction with cgroup
v2 and specifically fixing it in signal_pending(). Maybe you have a
clearer picture.

Other parts should be more straightforward (hopefully...).

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (6):
      coredump: don't switch a dumper that has no files table
      fork: refuse new threads while a coredump is in progress
      coredump: hold RCU while releasing parked threads
      signal: only SIGKILL interrupts a coredumping task
      coredump: parse a snapshot of core_pattern
      io-wq: order the exit bit against worker creation task work

 fs/coredump.c                | 66 +++++++++++++++++++++++++++++---------------
 include/linux/sched/signal.h | 17 ++++++++----
 io_uring/io-wq.c             |  2 ++
 kernel/fork.c                |  4 +--
 4 files changed, 58 insertions(+), 31 deletions(-)
---
base-commit: b813a7ec026ca59a444ba0a36c2e17ac823eeed0
change-id: 20260915-work-coredump-fixes-edf98c80fe78

