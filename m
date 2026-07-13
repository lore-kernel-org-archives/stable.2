Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A138CFFE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981681; cv=none; b=pOKXJ/fLd361jalszK1Hq1CFuChyTelBxgLYjTr3RDw4ea82vXpPtLEH88OFazo2MWnvMFBQoQW6bNeJZya9lKbMH/lssQqDdtlhIwQ3NfiBjsPzTe6otKF2bsTYv3iI3sjMEpR4QoaeWtbxn9sMuU170K4+27s1PSKguXW63j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981681; c=relaxed/simple;
	bh=B2PMpUvblp5hyxjnA/hFM71N7/kvSkCyfKwQezd7D7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZeWu61DNvw0T2qRToTTIsyxnINaBMcAGqrWk16Uo2wwOLpvSJ5Zi3UznoxpEOlpAjTHOeASAJVd9aEkRE65nzaDo9AF3UJTt6jhzvOUDqA+/RHzaHrg7fALs5MbUHn28VxgDBQJtwRdKKepXpyO1O41Pu+j0iEPkSvmYmhAfTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=PW/KNB5w; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="PW/KNB5w"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664c535f1a0so6231542d50.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783981678; x=1784586478; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K+d9JIH+nqFpF2LO/9v6L6+WLXY2mSweMKR5vNXN1VU=;
        b=PW/KNB5w8NegITRt9T+zxUQ8u703i/DfAluoZ22EwzzqxolTOsT+7+kJBzx2KAfGPd
         tx390vdcDqwoEZv6I+1Rsc7zcI8fApCUNhHK+8d1HJyWcbwO7GpuP6rFLFyHDjnYSNV9
         e75RUiLp+ahyMMhOZhTDfW4m+EaJTgOEe2b5Q5SMxYVPjlfMTzBuEPK7V1+xogqPfajw
         m+TTxXYiZDTm5kv96StZCcPlJ0Jw0T5lLoFsfs/IwCZWcn2S1tyod/QTNpQGRt4drfY6
         nqgZ7U2f6xlb93XRZquyvEayAyHdjwI4UmiWVEfN/Af7qLJOkmKILKuRl93CcdONBwX/
         VNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981678; x=1784586478;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K+d9JIH+nqFpF2LO/9v6L6+WLXY2mSweMKR5vNXN1VU=;
        b=qneIQ6kTl7+IMec+ZoJVHg2Vl3Z/5w8r71kfQaISZn/SuzZpMKdAxeghCqqJKZJ2wn
         KEq2NnUvCKCpKf4TLxXEkR8nho5R9j9eWBqhwU1cEgumih3wg/wwCfHMU9NfFoAYmmgl
         CoBPMMGdHp0c1QRfaAhQcvATRhSKhBR0b3Dl50JhvK0pmHWwpzULH9A1Vu7PmPMqZoh4
         L/2FU1sp2nnkH4esQZ2/tFfZWq4plrjbUmtj8mhhwxleH34vfdNZeaBhHki02Q9F6jzx
         HX+fbFNdvb3hXGwxJL5PM4HWuFzHll0YHve11j+VwgbV7/TsdUZ7RG20iRlMOygZvHoU
         vLpA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6Veapy9chTQH2eA2b1K4TJneeWs5mTGwJItHfhVSOsXoaiuZWPdoi6f6QPZ74/smqnId0AP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60A1V2paAE2cUkjv+gRd9fZ2dBoxQ1n43wE6+IlVbMScW/3+g
	PMGiIVZmkArG/vorfsTnY+F0qLYJpQq1YHogyBpettfuBePlo7tA91i9whEhNLT32Umkr/may+X
	pzlt5wpdu9w==
X-Gm-Gg: AfdE7clQ5ZsBZF+amKurWJIXVOIyRADYuuwo8XGfZrCwsbmWpR4e5xZfmeRFQEgsrxO
	Ke0MIo6FZSXU4wu/J/fC4C+RBbUFjzSN5FiW89mxlJhtVm7Z+syIsw3Rsh+qHxtOvlIBnv+LwCP
	MRtLQTWgFfU8VQZoyTzcF8iVj/ejCdu/O2wt0a1fdHcxygotuIjl0kEMUz/ljCVKxk8G7taxlyZ
	MswqzLTC2Ju7LSH+I0kNe7Vg9jE/bGVInpsfRyslbGBVhEDXn4iU01u9/u7RfhC8Cfc24VJrbmx
	DRwK6mm5ap+7Wn2rkQ5y3W/YmYttvc6BH6cPS3eh9RvYugp1z6R6dzuIRZDYeaQY8WJFKMxo+nw
	2d/UT42VtVa4Jt/25I1hO+1ZVGqpaXokf3xDRH450sdM/K580Czsm0ztrAzTT+OcclHEDwv+7yB
	8kwzY1vz8rqpkh7e2qgu5ytpgquq8GdRCv1dfZyGfHBpaIUdfgzFd27u31IKSX5wIojo0rodWkg
	7ut8exsx8GQit3m+nXbNPvYgcDp/oclmXxARAscG3lNno9TQmaeuDZHHyVeyzdoMnOcaSlCLkvb
	UFwSig==
X-Received: by 2002:a53:ecd7:0:b0:667:6276:63b4 with SMTP id 956f58d0204a3-667d7c426damr5293391d50.60.1783981677773;
        Mon, 13 Jul 2026 15:27:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e472:ff2d:20b0:742d? ([2600:1700:6476:1430:e472:ff2d:20b0:742d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66787a5a9b4sm14860155d50.17.2026.07.13.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:27:57 -0700 (PDT)
Message-ID: <1115c1f9c91381f2b6ceba9b62e28aa336776dbf.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: validate OSD extent maps before cursor advance
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: Milind Changire <mchangir@redhat.com>, Xiubo Li <xiubli@redhat.com>, 
 Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 13 Jul 2026 15:27:55 -0700
In-Reply-To: <20260710022818.3737468-1-michael.bommarito@gmail.com>
References: <20260710022818.3737468-1-michael.bommarito@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 22:28 -0400, Michael Bommarito wrote:
> net/ceph/osd_client.c:osd_sparse_read() validates that the sparse-
> read
> data length matches the summed extent lengths, but it does not
> validate
> that each OSD-supplied extent is monotonic and lies inside the
> original
> request range. A malformed authenticated OSD reply can advertise a
> far-forward nonzero extent offset with a matching data length and
> make
> the client advance the message-data cursor beyond the request buffer.
> This reaches the BUG_ON(!*length) assertion in ceph_msg_data_next()
> from
> the client receive path.
>=20
> Impact: A malicious or compromised authenticated Ceph OSD peer can
> crash
> a kernel Ceph client via a malformed sparse-read reply.
>=20
> Reject sparse extent maps that overflow, move backwards, overlap, or
> extend outside the original sparse-read request before advancing the
> cursor.
>=20
> Fixes: f628d7999727 ("libceph: add sparse read support to OSD
> client")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>=20
> I reproduced this with a same-translation-unit KUnit test on
> f5459048c38a, x86_64 with panic_on_oops=3D1. Without the patch, the
> malformed extent triggers kernel BUG at net/ceph/messenger.c:1117
> after
> the benign in-range control passes. With the patch, the malformed map
> returns -EREMOTEIO and both KUnit cases pass; net/ceph/osd_client.o

Do you have KUnit test? Why do not send the patch with adding KUnit
test(s)?

> builds cleanly with W=3D1.
> =C2=A0net/ceph/osd_client.c | 30 ++++++++++++++++++++++++++++++
> =C2=A01 file changed, 30 insertions(+)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c1810..76ba3abdad9b1 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/highmem.h>
> =C2=A0#include <linux/mm.h>
> +#include <linux/overflow.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/uaccess.h>
> @@ -5799,6 +5800,31 @@ static inline void convert_extent_map(struct
> ceph_sparse_read *sr)
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> +static bool sparse_extent_map_valid(struct ceph_sparse_read *sr)
> +{
> +	u64 req_end, pos;
> +	int i;
> +
> +	if (check_add_overflow(sr->sr_req_off, sr->sr_req_len,
> &req_end))
> +		return false;
> +
> +	pos =3D sr->sr_req_off;
> +	for (i =3D 0; i < sr->sr_count; i++) {
> +		struct ceph_sparse_extent *ext =3D &sr->sr_extent[i];
> +		u64 end;
> +
> +		if (ext->off < pos)
> +			return false;
> +		if (check_add_overflow(ext->off, ext->len, &end))
> +			return false;
> +		if (end > req_end)
> +			return false;
> +		pos =3D end;
> +	}
> +
> +	return true;
> +}
> +
> =C2=A0static int osd_sparse_read(struct ceph_connection *con,
> =C2=A0			=C2=A0=C2=A0 struct ceph_msg_data_cursor *cursor,
> =C2=A0			=C2=A0=C2=A0 char **pbuf)
> @@ -5856,6 +5882,10 @@ static int osd_sparse_read(struct
> ceph_connection *con,
> =C2=A0	case CEPH_SPARSE_READ_DATA_PRE:
> =C2=A0		/* Convert sr_datalen to host-endian */
> =C2=A0		sr->sr_datalen =3D le32_to_cpu((__force __le32)sr-
> >sr_datalen);
> +		if (!sparse_extent_map_valid(sr)) {
> +			pr_warn_ratelimited("invalid sparse extent
> map\n");
> +			return -EREMOTEIO;
> +		}
> =C2=A0		for (i =3D 0; i < count; i++)
> =C2=A0			len +=3D sr->sr_extent[i].len;
> =C2=A0		if (sr->sr_datalen !=3D len) {

Makes sense to me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
