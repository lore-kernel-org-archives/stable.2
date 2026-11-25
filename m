Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624788;
	b=gvnOU5oESRK1IJ6xZ1Z5NJuKptGknPD37MSOVKzKoggeQGGOxpJGM6NxnJwVRQRqpD7t
	 VJ6JZwzvOdAz9VoAJe+UTlDvLQnmgoxEhTAxaywiWed4yEXm7IG7iBiJDa1+TLQ+Ti8Kf
	 C4MDBMjeqmaRfhZ2e9WP8FAn0MpKP6sB8dhX4/YvdRZrBoDz0T3rjFSDhXrtKOBMoxRy5
	 2j54YjHiyKkCLXNSRu4q05ZS2LreJl5fye5iBt/6Xq3cYOYQSRoQZkeSC4GwfHHbCJHJK
	 4vCtgLLu6/5FhqrajM4kL1vTfD78sBsp/dt4To0P7hU771GNwkxggTjHtzkbUsMmKmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624788;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=dIJ6wlWtuq+YDcSjgi8UCsWxVOAWAUMRdLTxJIBzpgw=;
	b=Jg5W/11CIiwXXO5yqNVk0C7qxWcg6XFklvfmJqYa2ts9MubPRodfGz5MdNc4YLOHj2Mt
	 CedMcpmHx6D1I42wZSFrGfwrDMp32Y6jJ4htJ02qAZPLCpzXTQAP3kTInE8Ta4y6uG9qH
	 sqvnyxGV2Fdu0d8e8e28ZSAQ5OQoXB8e632xtReki/aVs3O5Q5yzlfb0FacXqUbEMm/jM
	 xBxj40e7J3K1QPp7h7ANQyt1BOQBXOXG2noOHefcITEC3hJoD+E2qdjUaMHrNCKj9J4Mn
	 jC3cVrhrngnz0oBNXX8PiLwI7FOuAAsa/9Li1z0ykd+cR4HWE6QYvOityQFlFUU3elw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC8606A339;
	Wed, 25 Nov 2026 16:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BE01F000D4;
	Wed, 25 Nov 2026 16:39:43 +0000 (UTC)
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
Subject: Re: [PATCH v7 02/14] PCI: rzg3s-host: Fix runtime PM handling in
 the NOIRQ suspend/resume phase
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20261019065025.2146539-3-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-3-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 22:09:33 +0530
Message-Id: <179562477303.5580.355686478965853081.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2541;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=5i7lydFJ+0F7rak/+bGf2JUiQghRnvZnvqM+p+ijHX4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBw9IGXEasvmJCvMTeSF1cGl80UbscjR37EHJj
 rc6/3QWGXyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcPSAAKCRBVnxHm/pHO
 9akgB/915LEZv5ZJ1jtPXakAsYWwbs5Z+HOzgmhNqdPKIt6DJSWsVQHpOW7ThyyGQa78XI4bHRV
 4hHwIIH3P5jPzzG+mDu7gYFQmiYowIwa0cAHw5q6rVHVHtvlT2yGO9nsGBofyug2TVIzWmwQ1Y9
 0hJ/zde7b8m7zmEs7naUegIrMTpR5AqQ7fvfDkr8NuM/DyKS/q+pfRW8gWMsXuzyKdSgcHCrqtF
 fDrZCvrczaMWfLUMcXO5u049MQeAG3uatTi60Ib8EOjbQbKt4D3yQMd2xxO4dMV2RYa8jfnB0H1
 XAGQfmjhyq+l65Zgz4j3MUOvUJnduWeF4bx72CXxgkgMsl2E
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The runtime PM documentation states the following:
> - During system suspend, pm_runtime_get_noresume() is called for every
>   device right before executing the subsystem-level .prepare() callback
>   (in device_prepare()). In addition, the PM core disables runtime PM for
>   every device right before executing the subsystem-level .suspend_late()
>   callback (in device_suspend_late()).
> - During system resume, pm_runtime_enable() is called for every device
>   right after executing the subsystem-level .resume_early() callback (in
>   device_resume_early()), and pm_runtime_put() is called right after
>   executing the subsystem-level .complete() callback (in
>   device_complete()).
> 
> The driver's .suspend_noirq() callback is invoked after .suspend_late(),
> while .resume_noirq() is invoked before .resume_early().
> 
> If:
> - the device is not part of the wake-up path, and
> - its runtime PM status is not RPM_SUSPENDED,
> the generic power domain .suspend_noirq()/.resume_noirq() callbacks
> (genpd_suspend_noirq()/genpd_resume_noirq()) invoke the driver's
> .suspend_noirq()/.resume_noirq() callbacks and call
> genpd_stop_dev()/genpd_start_dev() before and after them, respectively.
> 
> Calling genpd_stop_dev()/genpd_start_dev() allows devices whose power is
> controlled by generic power domains to be powered off and on during
> system suspend and resume, even though their runtime PM usage count does
> not reach zero.
> 
> Since the runtime PM usage count is incremented in device_prepare() and
> decremented in device_complete(), runtime PM operations performed from
> the driver's .suspend_noirq()/.resume_noirq() callbacks are no-ops. The
> actual power transitions are handled by the generic power domain
> .suspend_noirq()/.resume_noirq() callbacks.
> 
> Moreover, attempting to runtime resume a device while runtime PM is
> disabled may return -EACCES. This may cause system resume to fail when
> resuming after a failed Root Port reset, as described in a subsequent
> patch adding hot-plug support.
> 
> Remove the runtime PM calls from the driver's
> .suspend_noirq()/.resume_noirq() callbacks and rely on the generic power
> domain callbacks to power the device off and on.
> 

Going by this logic, do you really need the pm_runtime_resume_and_get() in
probe()? Genpd should also enable the power domain before this driver's probe().

- Mani

