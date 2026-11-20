Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185233;
	b=LAoRkJJNgJxEAFWAUaYviUT96ZgAAA2MWbmvPMknNJCHzBbnh+08+7oG63FLoN1bsfXd
	 BOst3SjlPgPQfzMyzEoRFm/xGnztShn473BVCDP1zD6bclJNagWe+u2+SzirQcb05dawP
	 GEQyxLmukEaQGRPqjhQj4oHKcu4Qh9XsbH6XczNHT9RBLtrH0OwBTQ1wmyoO6600TmzUK
	 5m5vw0vGPyU01+1Pkm+ILOoCM2TiWLERhKex72pTGUuGmAXeV8gE0EzOaZUixMO8JBSyu
	 rhaUW62qhzOx5d5gZsTyYKXrtau8cw+9w0q0lNupVB1OHV2c3O6Cs3IvI2F2RQ0HgfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185233;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Fy3WW09hB+rkP27DDiDOsr/F2JQ6kUcBqy1wnUqOGKY=;
	b=uu+lUlCTmQN9REKoHnOcwdHg2maTk6sLMUmft8xXB90fneurrCm7fzsqMjLpCSY3nF+O
	 oGvqUYl8yRgHYifAgf1J46UO3U5mohLVTcQMSS0q96oIPYdRzkpHtYn9lY4JNmalmIv1K
	 6TDAEa8MpyHeRzClB3rCp5D7kT8RskHlXm86izFlmwBRfiCHX7cNuN3o9HnfdMk1Ji/ZS
	 1kG64xMBkSzD39OwYuBQotq3jGNau734Zi2EMEMfqCQt27d3uCIOF2LBh/VT9S6Q9LUTU
	 KMb6vAxiL+fg/JdV0vX8YZVXBxZg5rCLH0C1lpIpm9v2cOVF7ilvkFbpkwZWQyCB86g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kP6gHav2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7996606A330
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kP6gHav2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21ED11F000D0
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795185233;
	bh=Fy3WW09hB+rkP27DDiDOsr/F2JQ6kUcBqy1wnUqOGKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kP6gHav2GQa1iDKRIlyXbUNoVUUQ6bzwiY7KGVt3Uongi7Bl7i9cci9WDEWJZvztc
	 hLsgKPBSH4JeI815Pd5DnJhZPovR0y2xXsfHmHIgfIUgHYpKVk0N7Z8PU5XBhh6sAz
	 9bgZE1ipS6hJRYKcOK6TPxiu3TZuZ0oIhTelgC6e9xioMq+hEtjju95EmN/Etqsn/B
	 A/EdQ037JyB0JGZ7XFHpZq20+429ZWh6bLiO7NqovbhoG9gus7Lj2hUxR4gN9jLc3V
	 Ij5Ju0kv+Stfhlda76toyjwXtXTe/lkynCTO2Rsz8gBtW5QFLRyxg0PeepL7yVdNPd
	 0XiEPWR2s/7dg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ae0a5c1715so20283211fa.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:33:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGbE82kLMr6hoJ9hqB7kz2aM/Oc4hS4cAdi5HjJeqnSWKIKLe1C3fBq+QxDRRYfeMuJcBzz8wc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YRREzdXbuKK4DY0fXMZcS+GaeAX+oGVp83AKxqinhABGIbYt8
	4OmEeIi1imYAhCfMEQxIPmSUBmEHe20WbJlBka+IhPnI0NmW91kHq85lKVaZvFPB+R9x2n42nl9
	dcF4+rJQFJxde1h+V+DASi0ppOPBP8+4=
X-Received: by 2002:a05:6512:3052:b0:5c1:4ede:6fcb with SMTP id
 2adb3069b0e04-5c1bc822591mr845358e87.8.1795185231609; Fri, 20 Nov 2026
 06:33:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com> <20261120134716.3027-6-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20261120134716.3027-6-ilpo.jarvinen@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 15:33:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hPOdbnWVrD8gVGS9L=WoXyO7REhWSgCJ26F8Fkzf94yw@mail.gmail.com>
X-Gm-Features: Aa3M54os8iRJ1ey_0RncgK8uRQ3y9Pr0ZgaUI1JtUGreQJfTIibpDnX303gkn5g
Message-ID: <CAJZ5v0hPOdbnWVrD8gVGS9L=WoXyO7REhWSgCJ26F8Fkzf94yw@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] PCI: acpiphp: Use pci_assign_unassigned_slot_resources()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:48=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> enable_slot() calls the internal sizing and assignment functions
> directly to size only the bridges in the slot. Use
> pci_assign_unassigned_slot_resources() instead.
>
> Sizing now happens after scanning all bridges in the slot instead of
> right after scanning each bridge. Sizing a bridge window only walks the
> hierarchy below that bridge, so the order does not matter. Sizing now
> also holds pci_bus_sem.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 632344f34cae..fc95d5814ecb 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -497,7 +497,6 @@ static void enable_slot(struct acpiphp_slot *slot, bo=
ol bridge)
>                                 acpiphp_native_scan_bridge(dev);
>                 }
>         } else {
> -               LIST_HEAD(add_list);
>                 int max, pass;
>
>                 acpiphp_rescan_slot(slot);
> @@ -511,12 +510,10 @@ static void enable_slot(struct acpiphp_slot *slot, =
bool bridge)
>                                 if (pass && dev->subordinate) {
>                                         check_hotplug_bridge(slot, dev);
>                                         pcibios_resource_survey_bus(dev->=
subordinate);
> -                                       __pci_bus_size_bridges(dev->subor=
dinate,
> -                                                              &add_list)=
;
>                                 }
>                         }
>                 }
> -               __pci_bus_assign_resources(bus, &add_list, NULL);
> +               pci_assign_unassigned_slot_resources(bus, slot->device);
>         }
>
>         acpiphp_sanitize_bus(bus);
> --
> 2.47.3
>
>
