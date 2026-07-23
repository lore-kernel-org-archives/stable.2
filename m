Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37994963A1;
	Thu, 23 Jul 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819219; cv=none; b=Ygoe9hvDEonzdCL9yUdBEjrcbQK7Tk2cEHvYkpbOdk2a/LKc3QxPeDP55v75hEptPIuToBR1RHE43njPqn6HdCcdpvHRRDI0+t2P+ZR2TqXnmqNahLT3UTsenD7YquXnFX4dPpg3PymrHnvOYeWenWmS+JGrfr6HsAaOy03gzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819219; c=relaxed/simple;
	bh=vnLtqN5YSzWXeVN3BDJxDM3rbzjZBhvwnQRkPt5qbNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hSu6OMDFgs7nVmkD8PRJW9QXrQ4Whdirwp6O1muF+9a/A28I4KjNIUQtSfFzF4LqehtynCzYuzOHRWYGQZbZNrbjVxy8IOUtsW/+L3Vg/cEb/sb3LGWiOIgShtq3PZn/z49V5tgF3mcBxVCQ0t3Gudao315Ojs9PNuachm+glmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605981F000E9;
	Thu, 23 Jul 2026 15:06:57 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 65FEC180CCC; Thu, 23 Jul 2026 17:06:34 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: bleung@chromium.org, tzungbi@kernel.org, 
 Jameson Thies <jthies@google.com>
Cc: sre@kernel.org, fparent@baylibre.com, chrome-platform@lists.linux.dev, 
 linux-pm@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260722195059.1420738-1-jthies@google.com>
References: <20260722195059.1420738-1-jthies@google.com>
Subject: Re: [PATCH v1] power: supply: cros_usbpd: Limit port counts to
 EC_USB_PD_MAX_PORTS
Message-Id: <178481919438.607778.10935942512984627353.b4-ty@collabora.com>
Date: Thu, 23 Jul 2026 17:06:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 22 Jul 2026 19:50:59 +0000, Jameson Thies wrote:
> Currently the cros_usbpd-charger driver probe iterates based on raw
> charger port count returned by the embedded controller. The only check
> is against the number of USB PD ports which the embedded controller
> also defines. A malicious embedded controller could return an inaccurate
> port count (up to 255) resulting in an out of bounds write and
> subsequent memory corruption.
> 
> [...]

Applied, thanks!

[1/1] power: supply: cros_usbpd: Limit port counts to EC_USB_PD_MAX_PORTS
      commit: 657cd3a42e937276262c0a8ae6b01a87004309de

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

