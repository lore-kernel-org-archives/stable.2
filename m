Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970693A6B8F
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125830; cv=pass; b=n4U/9kbKhqrxrNWBuXEjuwomMOExgEQSZ9qsd5vOzUm/I0k6NAihFD/mI9i3V36TulH9bkmoHAGku5aENUf2e5lAQiQTLaNkmnxXipRRV/nUnnwr5bN2+3XRM4o27M4vgY/P1PsEfbtcsVr4SLRYNR9pZGizJtQVJOAaYaeASc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125830; c=relaxed/simple;
	bh=zn+metQNd/XG/ZUgXyMP5j+F+hyFwWJJHw2ChAA//AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOTOB+8oNwV1v+Iz0j0HO83XxrJriQKwg8hr9JugQJzOi03kW/dxuA6G5ui7w6G3TT/GJpK6AFTb49ecQTUeQi54OLg5ZVksrku6x8OFN9zRy2oSB7UBfmqOFc0PoOMzeySddVydIREexo3AjDd0w0FMDodfnbetbdg9/pqUUdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7ZqVJ+q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjYIBu3v; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7ZqVJ+q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjYIBu3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781125828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zn+metQNd/XG/ZUgXyMP5j+F+hyFwWJJHw2ChAA//AA=;
	b=K7ZqVJ+qE7yKELZBT3yT7zFdj7n7FoOOoNDJPuYPRFEbnxknqg4PLUI9U8J8bpwnakEgoc
	sLXJrbBs/ruTnq8OVrynTsaeGDax7jjJ7rxo8iVOLr28vMrynDDcDPutRweIJAP7C2qz80
	/kDSXf9RwIxmGOizdUyxnHsG1PnVoJk=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-0zaYoK02OSyztn2mU6gbGw-1; Wed, 10 Jun 2026 17:10:27 -0400
X-MC-Unique: 0zaYoK02OSyztn2mU6gbGw-1
X-Mimecast-MFC-AGG-ID: 0zaYoK02OSyztn2mU6gbGw_1781125826
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304dd917645so8375696eec.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 14:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125826; cv=none;
        d=google.com; s=arc-20240605;
        b=I0VI1DnLfKx6jjW+Xcn8Pb3n7ewp3CHazzsP1ouO1Mx/hwszRDXw1RIFWjBXtCxltF
         F4eqqeA2XkyChx9RzwExvXxUR+XMcp3/ijZQmVGoVSg+pLRXbYczzXxMf5tbNz6XmLKA
         eY8zFTiq0HRZWxW4PpX//fdUF2RdOmgs+FRV594JltufnlMleQz/q5KM0Ihwd8NCuaxJ
         9d8WevUcvsD7Sq4tr4nCeJ3jF3LDm0mUOqNU/jszJqNbq58g8ZWVZZ9zSB0JtQOiIvGH
         Df4/Z2y7IPCSicDj2rwJLdRxN74Qa6IEWKIizju7g7pmAan5t7uC9fp+fOsC1SEFWOzO
         VkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zn+metQNd/XG/ZUgXyMP5j+F+hyFwWJJHw2ChAA//AA=;
        fh=oaV7Wy0G6rIrjt/m0nQl/7lhLt7DHYdKl61dOSL7Omc=;
        b=Li+PGPEdsl2w+dw0XCTn2zZD9OO/VGpPR5GcBWBGAYs6r3VKrEpjjvb+PMGNz6mQcR
         FJf/QJKS9H8yHGcdKwM46+poWLsmRvi0yWXD7zR1HNNVmZYOCONTj5VlcFT6zjkYlI/3
         IYwUrMdks1BYExq0j1vV7liRnI3+s7tovjczV0tG/csUB5XNRe1Vr6yFTKJGDxCRNKX5
         8MZeFcU2BIhb1A08zm8FGUCcHqkawifm+MXOewahZHtqjTQNtCtSaMhpD6WoDUpjB/Ps
         IGXHLvEoEQOi4XvmMc6b3f7fhmq0fgNHLcgG6HTFGAvaxSJ3hWkdqsQBqRZ6j5qW91w3
         8QmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781125826; x=1781730626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn+metQNd/XG/ZUgXyMP5j+F+hyFwWJJHw2ChAA//AA=;
        b=PjYIBu3vWBGLiQnBIurspXeDmPAB8cELUGCmL82/bR5t5cD3wL00S9Xa13KSYDJBzL
         4oCr0NIFRfggHiZ30Ecq9HawnOZQXeMgb60BkOjqwc7mo10MzIaBEPkM3bbgMWnAF9yN
         ebTxdx7bmyu3NFAiw6iVO/XinpFGtuWpAx6xyTSQ+RXdqe2ba8IiW4mOxiqWijupdFsJ
         dpCrW4qryMhUvGuWZBBCxD4OUSgg3D/z0G7qRZavyngHgWbq5vZIXKFEQBh3n6N/1Zoz
         Z9TPN8HTV+Ls1xJvheeB1NipZmO0Q9iT9WewYUnLmfZhgSi+YYK7zOGYKrORK9cupgae
         NXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125826; x=1781730626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zn+metQNd/XG/ZUgXyMP5j+F+hyFwWJJHw2ChAA//AA=;
        b=Cl63oCNAVxhHml5de4+ULSCSbOun59fuIu3P8wWyXRr+Tt8oFnzJuIoIWeC/7hFR7l
         g3Jq0DJK1biMOsLeWzxCuYOFCPwMo+RDNn0MZ36HZZp/GsbvKBdy7xfq9OBi8ZQr9MIm
         nk+4q7Do4xfrvp1qx+eMgBmG5duW3D0dG/Qe1RcXZFchpIbRgZjjDZPJNxawkZd9cgYH
         G0GCMBptNRg3jwsNlk1D4MOMTjaBYlmpbeYR7Fbhlgj3VjM75kw1ga92pu9v85FtK5Qf
         QFVtzMRHPKUFfi+dICh/vK4V6aNDJs+O6y0gdAPFUfp36BGkjaf1S57mKaT5WqI0ar3S
         yVKw==
X-Forwarded-Encrypted: i=1; AFNElJ+aCwKvrVJwLZFylWNoN9sqKAWvAZZujeeIc9/m6zoACYxZxAXNYv9k8iSWcDbb/ZDKQ6MjIT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzShMdkjQx1Yf71Mpxk21v6n4zkf/JWRh+99fzhlVX0HyVktf7e
	blrc3Usc6FSEHDWyDrn0QZlouXqCL5ky9IuY9PA7TQc+0icO7o91K1xQegefLa27SaBd/+w8g7l
	1NbCJD+hOk4c0/vkTAV7Sg9R+k5zcU7OuJptZEHo7xwCNMzGJeaHmzWC9iVv4Q6LUKcff5oWDkv
	swHWnJwCTH/3epdeczpPMFEIHz2G/g8xG9
X-Gm-Gg: Acq92OHcNoRMcO2XkEiRvhusJ62OeEXyeho3q+NuRtnpsSC0WvZwl/F5Bv7Orh3WoH4
	5pn9cbItaFWExjLL/h74kdLEJrvWdwW7JxbHJZQCGFEnpqCXOj7017Ytz/d9X6SmZ7HXowiu50o
	+Y+HbHiJY9xywByckn7cnJCB79kFxI6E6ayniuZR1056QkWU3Qe0zMTXf4qrX9RD307WY6/lP9o
	QmtBBzXRm5Vynayadrt1ro/ya9jsPVJpM26zM+4hvvzfUNk
X-Received: by 2002:a05:7300:8ca0:b0:2ed:e12:376d with SMTP id 5a478bee46e88-307ff820bdbmr662236eec.35.1781125825961;
        Wed, 10 Jun 2026 14:10:25 -0700 (PDT)
X-Received: by 2002:a05:7300:8ca0:b0:2ed:e12:376d with SMTP id
 5a478bee46e88-307ff820bdbmr662199eec.35.1781125825460; Wed, 10 Jun 2026
 14:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610141549.555605-1-jani.nikula@intel.com>
In-Reply-To: <20260610141549.555605-1-jani.nikula@intel.com>
From: David Airlie <airlied@redhat.com>
Date: Thu, 11 Jun 2026 07:10:13 +1000
X-Gm-Features: AVVi8Ce5IWVyE8AXhZUnTXwJ31lTOn-qBi0p3ZXgtCPUjD5gRdicD1lr4IH92yI
Message-ID: <CAMwc25ow-MehYN8u0EFkEW-JB2CYL+od9xja0WBK0-msWMHOww@mail.gmail.com>
Subject: Re: [PATCH] drm/displayid: fix Tiled Display Topology ID size
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 12:16=E2=80=AFAM Jani Nikula <jani.nikula@intel.com=
> wrote:
>
> The Tiled Display Topology ID of a DisplayID Tiled Display Topology Data
> Block consists of three fields:
>
> - Tiled Display Manufacturer/Vendor ID Field (3 bytes)
> - Tiled Display Product ID Code Field (2 bytes)
> - Tiled Display Serial Number Field (4 bytes)
>
> i.e. a total of 9 bytes, not 8.
>
> The DisplayID Tiled Display Topology ID is used as the tile group
> identifier.
>
> Update both struct displayid_tiled_block topology_id member and struct
> drm_tile_group group_data member to full 9 bytes.
>
> The group data was missing the last byte of the serial number. I don't
> know whether there are known bug reports that might be linked to this,
> but it's plausible the last byte could be the differentiating part for
> the tile groups, and fewer tile groups might have been created than
> intended.

I pulled out my spec, and indeed I can confirm this is the correct reading!

Reviewed-by: Dave Airlie <airlied@redhat.com>

