Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C348F00C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908620; cv=none; b=TXOd9r1jmLf6YrfUdTvyqKjHKrjsnwjzORrSgAXUOm7Xow+HyC/+D8qPNcMIVZA0U+Z1AHg91U7XRfEZXQ6G2oJ8gAwsiFoPbpMHZwkcEizCap1l8SIYsKe0IoGe7TIN60b2gzdrpeOyaN7HD1ohEqaU7/hAGEmmERar3R0s5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908620; c=relaxed/simple;
	bh=8dNXxg6QWDs94S89qscFUVRA62qWFCvWEhrJuYqboII=;
	h=From:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=VVbHAhOVnpK9ycGk5SlqpzZt127IflxhZDl4++n7nXEGZlv9LumOFJkpNFbkFrCNGSNG6dUtqUzfXy4KgbL4JO3uxEjHj+RjURvEfmOu/kcVVknxO1PQu0mDQGouOk05f2N8hvyXZBOQahSCllLEDdzFCJ280yO4TX61aDbxqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=eb0D+x4H; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="eb0D+x4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-type:content-transfer-encoding:cc:content-type:date:from:subject:to;
	s=s1; t=1788908618;
	bh=UvAuWdRNhxBj0zIQCudhRLv5rmtQK2pKzB9otIfWB+I=;
	b=eb0D+x4HmDxxkwSQspLBD2yTZm9cpULXzD46nXUAUt8mqzsFpFKwhNgHNvuq9hW6f3Bp
	PHISGPhitubhDdKKqNXJiNcjUVzFBczv86JXazy2ljYZzP1d4RL+m34dKw70jJO5g3+kPs
	sBlnGIN12niPikYe5JHrAQ8LSOizoZUOzhl2fzGxMJv7CDapxzXSTOXu+v+UdOCJQF+aH/
	szIN20KlUZH2tYQmPXFn0C/mJg4w5+x/4DM7WXGWpNj7FfI+9Ayxum4tQ8+vbYnvFRg6+k
	ehx2TS/2h+0EFn8DUJCoRVAqAV0RjqbtmZsgZ55WQcTwKlBcxL2smMz9NaxoY87Q==
Received: by recvd-75688db57b-dswf8 with SMTP id recvd-75688db57b-dswf8-1-6AA09449-12D
	2026-09-08 23:03:37.621995259 +0000 UTC m=+697365.363574854
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-102 (SG)
	with ESMTP
	id 8chTIw_2TIOU_JxuVrOLcw
	Tue, 08 Sep 2026 23:03:37.406 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v4] PCI: Fix BAR resize for devices on a root bus
Date: Tue, 08 Sep 2026 23:03:38 +0000 (UTC)
Message-ID: <20260908230335.62766-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8866d915-56d1-312b-ae68-b65021abd914@linux.intel.com>
References: <8866d915-56d1-312b-ae68-b65021abd914@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeSz1FDEY+=2Fil?=
 =?us-ascii?Q?XfP63B3wHcxN57FkNN2flTO16G2tHBREDp1ByV9?=
 =?us-ascii?Q?6wkjKG3MiIiHMwHVO7E4PGFvnjAFPVfRfnhH6oQ?=
 =?us-ascii?Q?KHxUIIJQOrcYyU8hfyeHN5GIxx5R0BkHpzzZ3j1?=
 =?us-ascii?Q?zMh0RMGZjMgDiHIjndloElm2fLmnVQQwOmI=2FU5C?= =?us-ascii?Q?c8qF?=
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com, bjorn.helgaas@gmail.com, helgaas@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, jon@solid-run.com,
	jon.nettleton@gmail.com, jacob.martin@canonical.com, stable@vger.kernel.org,
	kwilczynski@kernel.org, regressions@leemhuis.info, lizf@honeycomb.io
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

On Ilpo Järvinen wrote:
> Maybe this is what has to be done here, but I wonder if this could
> use pci_bus_assign_resources()?

Good suggestion, and it brings the else condition of this code into
alignment with your design goal that the core bookkeeping code should
be used as much as possible. Implemented in v5 (note to reviewers, I
am clearing reviewed-by as this is semantically different):

  https://patch.msgid.link/20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io

