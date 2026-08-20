Received: from 3.mo560.mail-out.ovh.net (3.mo560.mail-out.ovh.net [46.105.58.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38F44E040
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.58.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234502; cv=none; b=WGbHAIxjogJYg6bOeJCClEgkird5TItgfK+LBXaG1NjZ2qkLFrZKrqTTIWSIdBLt7qePPE66Hih+9o1CXjADrgbZOD+u0awQYjiYEaLuGXja0GFORjmphJ2weLD6/117193zJhOWhrudxuK2eO/ZaIUwOn1slD+ktSUfz8c8XB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234502; c=relaxed/simple;
	bh=MhE0/wkYHzuHF8BSJwZYmKYWzxbk/rV3AvAFxVB2hlA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aa6C7lEF0XfYFGt76+5K/GiPkcmFfhQQlC8JyHSxmbeWQHCOep92aPLe/z8mPAC3UEUNKWBHXwmsPsjiAdkLk6fyinPjek6QA45o5T0OeP/ANJj7BM2yYvdAxSyHm/XJSLi6cbydPYShz/VbwC0j7X3T4VjUfvxhE7+XQXrxJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net; spf=pass smtp.mailfrom=m-works.net; arc=none smtp.client-ip=46.105.58.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m-works.net
Received: from director11.ghost.mail-out.ovh.net (unknown [10.110.54.143])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4hQlTy6ZBlzBZfC
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:01:26 +0000 (UTC)
Received: from ghost-submission-c7b579475-5flvk (unknown [10.108.42.231])
	by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9EDEEC2980;
	Thu, 20 Aug 2026 14:01:24 +0000 (UTC)
Received: from m-works.net ([37.59.142.101])
	by ghost-submission-c7b579475-5flvk with ESMTPSA
	id V8Q4F7QIh2o7QAkAoCPlrQ
	(envelope-from <maciej.andrzejewski@m-works.net>); Thu, 20 Aug 2026 14:01:24 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G0040abbf50e-72bc-4bc8-bdce-1a017c43d6c3,
                    F470D10F53EF0FE28D2744507C2115D6BA5D3262) smtp.auth=maciej.andrzejewski@m-works.net
X-OVh-ClientIp:144.125.48.245
Date: Thu, 20 Aug 2026 16:01:23 +0200
From: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chris.packham@alliedtelesis.co.nz, daniel@zonque.org,
	andriy.shevchenko@linux.intel.com, sakari.ailus@linux.intel.com,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	maciej.andrzejewski@m-works.net
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Daniel Mack <daniel@zonque.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
Subject: [PATCH] uio: uio_pdrv_genirq: restore UIO name without the unit
 address
Message-ID: <20260820140119.1546932-1-maciej.andrzejewski@m-works.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0
x-ovh-tracer-id: 627689202175910691
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFYeV71eUF1BGjG8wIvXXDrYCzR03KSiq3cauo9fAV3JDgR6jrZ61LxQt+GNCa77uUPrRGctm5qtW+00wh82aFXRMJyEFrkNS4Nd9BzxEW5w3j4N/xnG2/PAkM6a+Ups5BUTGkvtd+e5My36OIFFAS50/sRt0xxbmE1aoXaLyXQl5xRqwuZFVHtVmxy5iLVi1dpXPDvDk+ZOKgkIWUBG90QDvbo9HCO0Zgqc0hPbwAVKWmaiw56AL6ATQvQGVEXrPZ59cPGmSQuK8WNEORxdtJMEeq67roRQZ3B1sSPZVTb1OMoQnwxdh6+H0iQ1+ZbLrGVUOVmy5f+16Nt/AxfsPChgFOA3xb654vzT4Fd8mKyEwHpgAWib8ODb+G0BfRx0Hx6zRNaLAN+FMLlolerxu6ctXvUbHYV6/4s3XgWuN2iARzyMzQm1uoiZCEgtStF8hZh790iA5TuTuZ+BNTrYSPHGlmXVA/C1Zm4v9ONownLqZa0D2byxTbZhzZd68yVyNX7U7HvvqGasN8jCV6ERSR0ThuaKUZiETOp6IQBEhGetQFzSJeep173dYTqvq7gSYiExy8beWFt5/dNi139p4X/IWqxBr3SnGjlELj8AO4K8PV9j3zYQDzi1BuFzU7Vog9xQBH7zF9Mi52SolfUfJr4eIvqJqOClATBQvF4sjo73w

Commit 90fa0280553a ("uio_pdrv_genirq: convert to use device_property
APIs") switched the driver to the device_property API so that a UIO
device can also be described through an ACPI overlay. As part of that
conversion the default name handed to userspace changed from "%pOFn" to
"%pfwP".

The two specifiers are not interchangeable. The printk format
documentation defines %pfwP as the node name including an address if
there is one, while %pOFn prints the device tree node name with the unit
address stripped. A node named "dma@a0000000" therefore appeared in
/sys/class/uio/uioN/name as "dma" up to v6.9 and as "dma@a0000000" from
v6.10 onwards.

That name is the only stable handle userspace has for a UIO device,
because the uioN index follows probe order. Applications that resolve a
device by name, for instance through the libuio uio_find_by_uio_name()
helper, stop finding it.

Nothing in the conversion suggests the rename was intended.
Documentation/driver-api/uio-howto.rst still states that the node's name
without the unit address is exposed as the name for the UIO device in
userspace, and uio_dmem_genirq still builds its name with %pOFn. The
"linux,uio-name" property added by commit b0297622a972 ("uio:
uio_pdrv_genirq: Make UIO name controllable via DT node property")
already lets a board distinguish several identically named nodes, so the
default does not need to carry the unit address.

fwnode has no equivalent of the %pOFn name-only modifier, which is
likely why the closest specifier was picked. Print device tree nodes
through %pOFn and leave every other firmware node type on %pfwP. This
driver could not be probed from ACPI before 90fa0280553a, so ACPI
naming is unaffected.

Should the unit address in the default name turn out to be wanted after
all, then uio-howto.rst is the file that needs the change instead, and I
am happy to send that patch rather than this one.

Fixes: 90fa0280553a ("uio_pdrv_genirq: convert to use device_property APIs")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
---

Notes:
    Found on a Zynq UltraScale+ platform where FPGA blocks are exposed
    through generic-uio nodes. Userspace uses libuio and resolves those
    devices by name, so the applications stopped finding them after a move
    from 4.19 to 6.12.

    The single generic-uio node in tree is renamed the same way:
    uio@d0000000 in arch/arc/boot/dts/vdk_axs10x_mb.dtsi reads back as "uio"
    before v6.10 and as "uio@d0000000" after it.

    Build tested on x86_64 with W=1 and CONFIG_UIO_PDRV_GENIRQ=m, once with
    CONFIG_OF=y and once with CONFIG_OF=n. No warnings either way.

 drivers/uio/uio_pdrv_genirq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 0c8d73e7be52..27268c8d1b94 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -128,6 +128,9 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)

 		if (!device_property_read_string(&pdev->dev, "linux,uio-name", &name))
 			uioinfo->name = devm_kstrdup(&pdev->dev, name, GFP_KERNEL);
+		else if (is_of_node(node))
+			uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						       "%pOFn", to_of_node(node));
 		else
 			uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 						       "%pfwP", node);
--
2.50.1
