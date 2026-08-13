Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA223263F5D;
	Thu, 13 Aug 2026 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601782; cv=none; b=DYmfEaiXgpWPqIUeZkoth/+cMg+on540MobNGG/XJPX5noa5dzAUYB3ZnbNU75zXC+N006YEbeoUnNhFv8YaE41S+irUrBKbKVQJmkUGX3zDBHJNkntR4Jc2zIYeLIP6UkuZ7yRjTgUJf0XyzaCzq3yzdmNNkIG31ILMh54DKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601782; c=relaxed/simple;
	bh=nNDDz7PDs5rexYiufaMWc7fYDFIs1x8NBJ3FhvWnVRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdPVPoWLyZ7Qn6ZwqnxCMMJ9TtyRWkpPmkbBb4qKP7J5L5T+tH5ZUfF4JvK8BHYi+4VYXQtVepVyvXwyvpxJ0d3rvco0KoQ4Q/mlu7ZLImXc5bvSDNd4pjvt2Mz6e9NKFkaUlMb9YB8HeK/UCr0fc1uCPVsk4rhRb4I7iy6DQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyfv3FWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyfv3FWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B299A1F000E9;
	Thu, 13 Aug 2026 06:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786601780;
	bh=EiVQC755VC4oCluUpZOCRd7aWnOtXAYAXnY44dATvxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vyfv3FWZVM99o9AGEzZv2sls3WLEKK8hAwD3s07yUMgl+XmChwYRCQaujCchascIn
	 aHH1UjvOzr8t69VfA7fXaOgvOp9lysgVxsA+2Jo4Qy8UidJFHglpecHX0vvbq2dMus
	 3igrC9ViaL3ag+KbBE724G096RyLJ8J7TownWw+YTx4xdwGo6gUgYlsbsrKpea17Mc
	 t1LF4hURVOd3bQrbTN4l1Y24oAq3WcGxomfDruOVDg3gus8VykM6nBLyvUdEgibwCw
	 AOI9rRcIaIcHshe8OdNwcRU6DIDGaFm7kyukhpIHvpE8qeoAdaxZsXA7Ylanqc8RMo
	 T2JXapeOspNEA==
Date: Thu, 13 Aug 2026 08:16:04 +0200
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
Subject: Re: [PATCH v10 07/10] PCI: of: Clear fwnode->dev during root bridge
 node removal and error path
Message-ID: <k2uhgrmqtp6g6px2fcqbla3zuyb6ybwjp3w5ohjuqaphzzygxp@lsjauwsjkyb3>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717145147.823749-8-herve.codina@bootlin.com>

On Fri, Jul 17, 2026 at 04:51:42PM +0200, Herve Codina wrote:
> During the of_pci_make_host_bridge_node() call, an OF node is created
> dynamically and its fwnode device (fwnode->dev) is set to the PCI root
> bridge device using the fw_devlink_set_device(&np->fwnode, &bridge->dev)
> call.
> 
> On removal, of_pci_remove_host_bridge_node() is called and calls
> device_remove_of_node() which in turn set to NULL the related
> dev->fwnode.
> 
> Later in the removal sequence, device_del() is called and runs its
> cleanup logic:
> 
>     if (dev->fwnode && dev->fwnode->dev == dev)
>         fw_devlink_set_device(dev->fwnode, NULL);
> 
> Because dev->fwnode has been cleared earlier, fw_devlink_set_device()
> is not called and leaves fwnode->dev unchanged. This fwnode device
> (fwnode->dev) becomes an dangling pointer.
> 
> If any reference to the OF node is held after this removal, the pointer
> is still accessible using the OF node (np->fwnode.dev) but points to a
> freed area.
> 
> The exact same issue is present in the of_pci_make_host_bridge_node()
> error path leading to the exact same dangling fwnode->dev.
> 
> Avoid this dangling fwnode->dev pointer by clearing it in
> of_pci_remove_host_bridge_node() and in of_pci_make_host_bridge_node()
> error path.
> 
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
