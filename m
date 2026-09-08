Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0E491591
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895460; cv=none; b=LAEE0rmVDqzNfNwEqQVgVGE5HqlZGi7gYCyU+BsXOgr5IwzMLpm/M1cVkjF6Xx1oaxzFAOjut27727526ZTkGvxkUjKFSHHCPI1jIfQNZnY/j/MKF9dc6SR0w3gr9dlR4zEDKLuv+TwP/XimrYBdEwbGNVc0lUMJTphC06yFRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895460; c=relaxed/simple;
	bh=C6vW7dRME1Gb/wGMSQ238TNMF+iIrlz8mbsHZrOwe0o=;
	h=From:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=I7SNRIrItH9tfwoWdrue5ak0qR/U9m3lm8T7G15hZhOIYUZrJp03ZeCjuxDyZUjRfwORBUKXGaB/Ypzan8vCjOkrB8ihi0g3y1OAJbXEsyAqYQteqAYWAndGignaxZPIkw0g5SIaVQhSOx9e7RahPSolQQOKr8udJ5SV7D25HKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=Cqox37/R; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="Cqox37/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1788895457;
	bh=deZpy86mdL+0FuQa302UpRu/UqHamHeqdhK2hRsukYY=;
	b=Cqox37/RxfSoxCDREwmfIPUkJ0lcViR12E/3Dn2uFcp6tIy6IW8vUfelqSwsMqfWfdsY
	NMiioaWE2yR+3kHDyYiX2rk2pJgiggmxGV7aYxKchRKu/OS4xnF78kqJUqm5lDQ9egtBnu
	07+ZCJ7q0Nj7PN6ToCW52wkmeodeEvc8Zn0W3JH0MlnstODJTkLz10VFpqEfjH2G3oe0l9
	c/pzaW0b0RgZ9QWX9Ii3AQLMwQiO+eEtvZgTEyD4aMdxDCve2Ej/nUqwjEZpF7HERhLizV
	l1kOQTv++qtc2eu5QwAHMompuEkr1Yc9O2NN3HmlY0GAAd3fkHcml4zHwivx9P/A==
Received: by recvd-b9cff7684-gvzpt with SMTP id recvd-b9cff7684-gvzpt-1-6AA060E1-35
	2026-09-08 19:24:17.30759247 +0000 UTC m=+3630789.492945539
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-58 (SG)
	with ESMTP
	id gMk5nyFdTC6pjARQljyq8g
	Tue, 08 Sep 2026 19:24:17.127 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v3] PCI: Fix BAR resize for devices on a root bus
Date: Tue, 08 Sep 2026 19:24:17 +0000 (UTC)
Message-ID: <20260908192415.48843-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4db878f3-1c55-4ecb-93d8-a97a5e0c7a29@leemhuis.info>
References: <4db878f3-1c55-4ecb-93d8-a97a5e0c7a29@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeYtV+MVTZw+O?=
 =?us-ascii?Q?DXUD7zff+Q6gIw0rZAuCnUYZjLK8jUMlsBaIOkJ?=
 =?us-ascii?Q?ufBXuikqhX6NmCt8X2+kvKWLI0W3sSe53yXXTvb?=
 =?us-ascii?Q?vkJ5R=2Foiyg12eRXknNOJzw6aZAwy8cAO1AHnbDh?=
 =?us-ascii?Q?TuZ3=2FmdWnGD7sfi7qEF0GDMT3RvhohJP3fCHSZO?= =?us-ascii?Q?NH8z?=
To: regressions@leemhuis.info
Cc: bhelgaas@google.com, bjorn.helgaas@gmail.com, helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, jon@solid-run.com,
	jon.nettleton@gmail.com, jacob.martin@canonical.com, stable@vger.kernel.org,
	kwilczynski@kernel.org, lizf@honeycomb.io, linux-pci@vger.kernel.org
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

On 9/3/26, Thorsten Leemhuis wrote:
> Liz Fong-Jones: is this regression fix still needed with 7.3-rc1? I
> assume so. But if it is, I guess it would be good to state that; maybe
> reposting this might be even better, as I fear it might have fallen
> through the cracks.

Confirmed still present, and thanks for the nudge -- checked today
against both v7.3-rc2 (mainline) and v7.2.4 (stable):
pci_do_resource_release_and_resize() in drivers/pci/setup-bus.c still
has the original "if (!bus->self) goto out;" with no reassignment on
that path in both.

Reposted as v4, no functional changes from v3, just the resend plus
a rebase onto current mainline:

  https://patch.msgid.link/20260908-pci-rebar-root-bus-v4-1-2780e9c22e08@honeycomb.io

