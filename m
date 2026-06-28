Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1977BE63;
	Sun, 28 Jun 2026 03:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618751; cv=none; b=dLYJD+DvH56IxkyZGkHV9LkzkZdMTznALrqYSPQCEF9/gWihjtAeacrvzo9o5a2qnE2dpe/QUHKlEo9NcnZ432kMoImHip30AJPbSUScQ/yqk2VLrlFNnUMMroqOqs+LI6wxj0cSkL2vLCnylp0FvjQDc0WZjQ/oEw4sJb5fJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618751; c=relaxed/simple;
	bh=GDhZtVi/HEjSDmzrwyQe8n7Rbfqy6kPel1JN9psgbKs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SOjaSlg2IuJF9u4r4uIVEraQS7P/hy6Br0GDOIOs7R2eL6Gm2s1c+xw3ztA3yWQIZynY7lI1+rvQuYKvN+5MZADrvXgVlDwKMyjaMpF9nHiGQ/ZoTo9FJlB2j8TgZykv5Jsir1nzXJGucxqRdWyaVYTZ2n/LX6WIslOFBnrtDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S2;
	Sun, 28 Jun 2026 11:51:58 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: x86/events/intel/uncore: discover_upi_topology:
 inner loop leaks PCI   device references from pci_get_domain_bus_and_slot
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626100031.31494-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:51:45 +0800
Cc: mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 james.clark@linaro.org,
 hpa@zytor.com,
 linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AFD696C-F83F-4DDF-AEDE-E7774C8859D4@iscas.ac.cn>
References: <20260626100031.31494-1-vulab@iscas.ac.cn>
To: peterz@infradead.org,
 mingo@redhat.com,
 acme@kernel.org,
 namhyung@kernel.org,
 tglx@kernel.org,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAA33NRbmkBqExKqAw--.34181S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4DGr43XF18Kr13GrykKrg_yoW8Xw18pr
	W3tFyxKFWfWas2ga9ru3WS9FW2yrZ8Gr9Ygw40g34I9ws8X347JFW2g3WYgayrGry8tr13
	t3Wj9r48X345AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07jDKsUUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2pAiNkY1AABsj



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 18:00=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In the inner for loop, dev is repeatedly overwritten by
>  pci_get_domain_bus_and_slot() without first releasing the previous =
dev=20
>  via pci_dev_put(). The err label only releases the last ubox and dev
>  references, while the references from earlier loop iterations are
>  permanently leaked. Fix by adding pci_dev_put(dev) before the =
overwriting
>  assignment.
>=20
> Cc: stable@vger.kernel.org
> Fixes: fdd041028f22 ("perf/x86/intel/uncore: Factor out =
topology_gidnid_map()")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> arch/x86/events/intel/uncore_snbep.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/events/intel/uncore_snbep.c =
b/arch/x86/events/intel/uncore_snbep.c
> index 215d33e260ed..cecc1ce0a248 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -5494,6 +5494,7 @@ static int discover_upi_topology(struct =
intel_uncore_type *type, int ubox_did, i
> 		for (idx =3D 0; idx < type->num_boxes; idx++) {
> 			upi =3D &type->topology[lgc_pkg][idx];
> 			devfn =3D PCI_DEVFN(dev_link0 + idx, =
ICX_UPI_REGS_ADDR_FUNCTION);
> +			pci_dev_put(dev);
> 			dev =3D =
pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
> 							  =
ubox->bus->number,
> 							  devfn);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

