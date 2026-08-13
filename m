Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF931E85B;
	Thu, 13 Aug 2026 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601857; cv=none; b=gebhxlwvy5H5M3CkVGCUWaXrLOzFFiDIEj07gPXvXUq0hV4lU5BM4GgVMrcaOkXZz+EKjWg0bxComjseiLj3819uHDF9Nn3Z6J6Sv4OJ15tZivbc5V67EhCnFQsYmfuoIngb3IiorQVXy+o5+M1m9Fibhg5OrfwFfY394oZpBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601857; c=relaxed/simple;
	bh=z9G4N5ySez6K/OvcDFMO2s/RhZrVwmETPeCrg/mdxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBO7TdCLLb8kG6aPKfI+MAjXjiP1IvIqGazpU622zt0gGQNVcStwPb60SZC2UWvAoqaXPJUcTkGpXUWveHE1XvewN3EeHtzwUrsNYc20SeVpTyFpaDSovjprNnD16c45h1hEG4GXbDmcVUDnYeVg7Rflli+r79tpIkB+tzlRBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKMwQCK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKMwQCK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E111F00A3A;
	Thu, 13 Aug 2026 06:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786601856;
	bh=3hkGajI2L3VCIaYqx24q5REez+3Wl5xg9c6GVH/Friw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UKMwQCK28TSILWRtZYIiOcDLDZRvrYVvr/6WUGonpE2gXO5sNj35XDxJbbXJaZfVf
	 TQ3isjzHk5zA44MkIUI7rf31xc96ZlPoM29T6vDCVLY5XSo3+bi4CXnmSQnLtGw5LR
	 l9eUDYCo81v18wDWy3hLv4BuLcEO4693tIm2NyYTz1BHVm9UchV8r3znS6zj0kbwzx
	 suKUgSmAmTepJhXFbvH2zhssyQebFtQvBZjH2GwlqUVbGWRQFnVCyiYtxadBubaTPz
	 JnLWT7alQeMWPuhaB8sD3fhgHgzTKVcvx6WOH5IjXYGoSL/BeX/EVklUkktbmuizf0
	 Sg1WZcz2PdcVw==
Date: Thu, 13 Aug 2026 08:17:20 +0200
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
Subject: Re: [PATCH v10 08/10] PCI: of: Set fwnode device of newly created
 PCI device nodes
Message-ID: <ir6y6vwejuqjpz3dx37xadojinvxniduzv5tycylnhidqs2ma7@5v5hy2vwv6qi>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-9-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717145147.823749-9-herve.codina@bootlin.com>

On Fri, Jul 17, 2026 at 04:51:43PM +0200, Herve Codina wrote:
> Device-tree node can be created when CONFIG_PCI_DYNAMIC_OF_NODES. Those
> nodes are created and filled based on PCI core information but the
> fwnode device field is not set.
> 
> When later an overlay is applied, this confuses fw_devlink. Indeed,
> without any device attached to the node, fw_devlink considers that this
> node will never become a device. When this node is pointed as a
> supplier, devlink looks at its ancestors in order to find a node with a
> device that could be used as the supplier.
> 
> In the PCI use case, this leads to links that wrongly use the PCI root
> bridge device as the supplier instead of the expected PCI device.
> 
> Setting the fwnode device to the device of the PCI device allows devlink
> to use this device as a supplier and so, correct links are created.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
