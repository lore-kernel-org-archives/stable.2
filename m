Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A551329C60;
	Thu, 13 Aug 2026 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601656; cv=none; b=NglAl/lLMPGATZVh1XZnCcw0sMM7vLGslgTGJdxnlVrOOK1dDFIgRRcR3ZtQ0H9KQMpMCodgKeqO2z3safeTlFmgGhrvy6X4e3VhEipqO5+8POK5TYevse/CO/uhKbEFK06l6AelbYNzgriXON+0RZhyUFUjgVuMitGMXQaDd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601656; c=relaxed/simple;
	bh=N7bLYYpfEmOPMJSVbIx/4DvgisfsY6K/fwme5uJA3qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv1U0aH/ythc/9WD7UKO+D5W1cn8i6NNF4GCGkQMRT0Kb7ARS9zYn5nbsJF8gz8xi1PEg70CJvOKpikEkPdUsGR1HdwksIuNfSwsI7DcTowfc58WMl92upzB4kqIirzacwEFeShjcdTumGlIKqOBZLmx5e2Mpw+0HOTTg0sjciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9q+SlQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9q+SlQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299191F000E9;
	Thu, 13 Aug 2026 06:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786601654;
	bh=hXgxrqF5WzE2LQ/fhkXb+3Tnh+7LoVRm7x5a3Nebzpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n9q+SlQYx4Wx80YT7HgAzAz4jS2AiUpfcm3L2+yII0LxrTZQ/fIfi84OUz6rt+Ga/
	 z2EFk0PFPUfkb6C6GC2JCu0W7QIwLZCb+oNXhuMVj1CBP1EqXO5cc90D36I9C1ypba
	 e4iKV++0sJYdjEFpIYdQaovsKt/ups6D6l14vCYADMdgdkdmP3RGfpOSA5/pQ0ZbMz
	 +55uCIHgH9gXZnanQcoYJRG1oPqKdmU/LVUMwsRFAqX8PUWs4UhANHt3MhD4MxlRYY
	 kvuM23UEobH8vtaQOeDgcWMPi/xmTTp4lhAH3emRC26P6iwo+2tV4YL/DFIjRdLZc8
	 NYeo1w6DQkvmQ==
Date: Thu, 13 Aug 2026 08:13:58 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Richard Cheng <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Linus Walleij <linusw@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, Lizhi Hou <lizhi.hou@amd.com>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v10 06/10] PCI: of: Use fw_devlink_set_device()
Message-ID: <qmdu6iiffirxs2we2eggepq72hdoto5mmavbpgewunw4jorf7f@7b7tgcagrixw>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-7-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717145147.823749-7-herve.codina@bootlin.com>

On Fri, Jul 17, 2026 at 04:51:41PM +0200, Herve Codina wrote:
> The code set directly fwnode.dev field.
> 
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
