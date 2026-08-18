Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3E42E8FA;
	Tue, 18 Aug 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073104; cv=none; b=srZVEJULBKnWM2oZRRXB7gPVGom7XTcVd9hfMjj76J2cfOou0NaFqiGH4K/x0iLCmDHRaJMt/7Y6cDWD+PdSff2OhWJ4Db5XsmZHcxPG5+jfhuQEbs6J38ufrzKId4lpP1JUMjpAlfiMy7jNpkgXAuoFJAJVUvw5wAUpcaYhhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073104; c=relaxed/simple;
	bh=lZh4VQTt68VOHT+8YjIBZnJWuVmjw2fszleC4QzJfmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DB82rWwXJPL/mtvZtsOYe/v1IVwEPhNO9XxAD3RVJEeCxVuUaoeIUvS+D2FR7NCECndN04cjGzmy9+L7KEK3uP37ZMeujkxOyQK7yq1Faz4rZggzKKh9GyzOJg7cwEnM7WqABfUe7zj+s3LDJdt/i7TUKVFveMEXFSYa8gHEWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=ec5wbqKd; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="ec5wbqKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1787073099; x=1787677899;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=lZh4VQTt68VOHT+8YjIBZnJWuVmjw2fszleC4QzJfmU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ec5wbqKdwI2MGtKvSYp909n5zBCHxu5HbNYT52wIXHVxFOz7eBJ9x6qiUEw8iBBN
	 VEujlL4V1DH3RZ+Qgz2s+Bs4+i20Q8yNyfpuOkN9c2SccsLr8kO3QJm9Uk+k/19j6
	 Gq6hC8GIhrCmVh6TMr91s9BqiMZP1oS2u0WZtk5X/lLD8B31uyOjZJa0cUmzxNcUJ
	 KWVDyDOix0QDWrWzgpfgedK4u9azCFUW6oeT4jzJc42hwPis3wfNIbKpaQXGF9QSV
	 EnrDr68md28bpVoIjpki1HdgucAoEJwmviVKHquytt66emmsMY3lsmxruE+Nm1h7V
	 BcXpFYLFVBR2IrpTNA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N7Qp3-1wtJKW43w5-00ruUl; Tue, 18
 Aug 2026 19:05:54 +0200
Message-ID: <1aeaa585-79f2-4f43-87b1-2ae3925b176c@oldschoolsolutions.biz>
Date: Tue, 18 Aug 2026 19:05:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
To: Marek Vasut <marex@nabladev.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20260817182302.146546-1-marex@nabladev.com>
 <aoSFjbydIiu4KyW0@venus> <dfac3134-920e-498e-a59b-720a6c51b82a@nabladev.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <dfac3134-920e-498e-a59b-720a6c51b82a@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PzSJGJc6iVkBZfSwhp6gZRrDM2SOjFInsQnNV9p+cHWoeWjmO3z
 JmyKu1hbzQoNiwx9JPnsKFCiRtS5ghuSG7UjsEgjGlsWYgqMpLQSDA+6ZGaKli09xUlSZth
 lpCdK3q4N5YPsSDrDkyGg3uG1hk4k8lyWFD5Hcz+JdEhUDgbzLftXpEELSD+yUQvl9HmDYG
 yCVzBAPBuA3iLZUtv8Cyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uWBz/Pi3P8k=;3VDVq3mIPS+zvGCTRhPVOKdtT87
 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

Hi Marek,

On 8/18/26 18:56, Marek Vasut wrote:
> Hello Sebastian,
[...]
> Could you revert f576c75f95a5 ("Revert "usb: typec: mux: avoid=20
> duplicated mux switches"") and apply the following patch (equivalent=20
> to this patch, applies to mux instead of switch) and see if that fixes=
=20
> the T14s for you too then ? If yes, than, I think this might be the=20
> proper fix rather than the revert:
>
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 4a4297f15aad3..afa6fc1813978 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -294,6 +294,8 @@ static void *typec_mux_match(const struct=20
> fwnode_handle *fwnode,
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D class_find_device(&ty=
pec_mux_class, NULL, fwnode,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux_fwnode_match);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ERR_PTR(-EPROBE_DEFER);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip duplicates */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < TYPEC_MUX_M=
AX_DEVS; i++)
> @@ -303,7 +305,7 @@ static void *typec_mux_match(const struct=20
> fwnode_handle *fwnode,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev ? to_typec_mux_dev(dev)=
 : ERR_PTR(-EPROBE_DEFER);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_typec_mux_dev(dev);
> =C2=A0}
>
> =C2=A0/**

I will test that one with the=C2=A0f576c75f95a5=C2=A0reverted on the x1p a=
nd=20
sc8280xp boxes I have here, let's see. T14s G6 shouldn't be affected=20
either way.

with best regards

Jens

