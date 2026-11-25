Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625398;
	b=z2eijaeznc9z0Z89FqJJaYFgdufFQgUy6xQyNHRKmERcwsRVT3WPchkwgodeQnvrMDGQ
	 OydpKBYxS0c0i9aM7mOYd3fOQdNtjV/0p0qqMlsgXOCxZZUN0adbB5ICwysDZCDbRSZrG
	 L8R+lXSql9NK2GNyIsS1nwvN8Ga361CapIlVledTDNoaxnw5Iv+DLpKSYblfmlRwEJMXi
	 NYyDlWtl2N2m5L0RD/HjdD6357vnTUp6H7pBGKrKh41MI7nvYpPikWbLIcT5R1fLfv52A
	 k/e91M/hmN1NjqPi0vutG+N0m0VGtO/TpK4uWIQHa4pxS9YbPT1KrA9AV+NMPItvSTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625398;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UezByG7U2h9IqUKFRk/D6mBTIPmbDfL92nk/JrUNots=;
	b=GRQt8dpsbQmHAgoiz17gD0ZTDmXh6R0F8pi2aJgFr6hypRcWEpk/3jQOSdQh2WPnAGBC
	 B3fX7/JWYKLCSQcCckpmHvRbmXgkBRvog0MtnIdr+RXY/5Y+ALNk6GeYLlwNxcGw/axBp
	 TVCj1cmGh+WC8XLG2SZ5Dh3bPe0iQzIVbMbDom/8SbqNcaULMFkDDvvzj4YZ9wjWo1Met
	 uUApPUCEa/uYrZbOq+hZYc0dGeWeCqc2xGWTO6sUCePCtpldHiXBTQLoX7lDcVHRdeC+9
	 80EzjyuHsU6XDkYJ5hscp+zw1yXuGkjO5n6+SssZ9k7LMja1baaI+SHTrG1c+awDIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560F606A32D;
	Wed, 25 Nov 2026 16:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5A31F000C0;
	Wed, 25 Nov 2026 16:49:52 +0000 (UTC)
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
Subject: Re: [PATCH v7 05/14] PCI: rzg3s-host: Initialize the IRQ domains
 after the IRQs are masked
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
In-Reply-To: <20261019065025.2146539-6-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-6-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 22:19:48 +0530
Message-Id: <179562538809.5580.13436039230126479202.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZvF9ztr21DpWZoUrOG9CFbSng8ecM0Pad1c9yPt2Q7E=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBxGwZCu3h+uHdoIiCDAF21b017dHOkwcFi8ki
 fqfxnYyYMaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcRsAAKCRBVnxHm/pHO
 9UxjB/9Ny8WXQiS8iBiz2oORKmlANGxRSx2MwqCifikl3Pd1Gr/67B5vEr+dicvb6QKzfNyWPw+
 x96y16moSYEPhWSNrwepreGGh41KmT+hxIwAwMKlLr0Zosy3hJbk1zyPqQlMogIvejSx3OdM01E
 XtYh4jIPue8KwBTJMRj/nfwANlUKgTRcpw7sNCY0kbYqh+4iTtgfC5AYcS4R/SHBgewDHa/Stkv
 /2o6+AhNMtOs6QsdnAp+gGJ+NCJhr4Pdt+XhZKqTMljWaT6ONCNqm6M8htRqcVr83VllXPXV7Lt
 2JWYZu+S93qzjAgbAoLujGU8NPaYXd4RvSTqBWZj5AQYlnyN
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The IRQ domain initialization requests the interrupts and installs the
> chained handlers before rzg3s_pcie_irq_init() masks the controller
> interrupt sources. An interrupt left enabled (e.g. by the bootloader,
> or latched from a previous controller state) could therefore fire
> before the controller initialization is complete and be handled on
> half-initialized state.
> 
> Move the IRQ domain initialization after rzg3s_pcie_irq_init(), so that
> all the interrupt sources are masked by the time the handlers are
> installed.
> 
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v7:
> - none, this patch is new
> 
>  drivers/pci/controller/pcie-rzg3s-host.c | 31 ++++++++++++------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index cc985020d962..94345d6f0bee 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1418,7 +1418,10 @@ static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
>  	return ret;
>  }
>  
> -static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
> +static int
> +rzg3s_pcie_host_init(struct rzg3s_pcie_host *host,

This split seems unnecessary.

- Mani


