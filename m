Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795155764;
	b=g6x+7sJiYcq0OQsr2vrzXqzJ1kKCXvAbDDl1oEQP6KNASTTiw38vfU8a63mXprYrUN81
	 8WxiDnHK/oOlLyEKQFB6L1JBh8ngav4q+4yAQc9/v2Bf6PLqIlZ/XlI8xlgcidozAYnYv
	 LaE75zw8EmxeSDzmDnJN4tlAowDF3mFE0b50/1n0SImivgkjr0h2DX8KMXfX8kmj6U966
	 p+F3G+f6kjhXr1akSiI9KNOT9nLd4fsxvANveTW0sxTG450f1iAmYJxuRAvn5D//wR+3f
	 Vxvvv1vE0RJ7GzKoJdZ0itsG4xVI5ppmhOm+3XPoe9RQA7zyvPGm2yBrpLk/Gzd3ySA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wMblIadmu9KQcO5zsoe8cd5I4mzAPI5XN2P8ppPY1XY=;
	b=x70//mWpfMsDHyXUekaoN6Osbru3VJnVKtd0JmfOg6j2wPWnFCapOZGcLa3PU9Z+/580
	 r/KVoM8Z0vSANyPp1YyAR02hGwjTl7+KObMT0U5rBV9025aROzhuPYASsRTmZFAv0dtGS
	 3Iy2FggBwLtLzGXnZaEjxe85k/XsUNfL0UxKhGxVPXF0xOeJZOc6xBGtYYG47ZgiSV8gH
	 kvCNbZHdizTdG8ehmicc7xhW/isU6bOkW/z2etUYAs6jo+G2mH3k78rnvUgecf7XaAWjZ
	 mE6cDgIAKGRK/pdxwdGrKOoe4YZHTUlwv3u/JFg7iNAzW204Ph1DM+n2vWo3k5V7Xmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipxNlIEi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44C60A2600
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C44C60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipxNlIEi
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b24f4b15c4so644529c88.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:22:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795155763; cv=none;
        d=google.com; s=arc-20260327;
        b=W6Ve7lZ221ANJjMoiUCNCDFcPHpm8n6lERcOySf3tooUPHFfYORgGa4RV6kfMx0oQM
         RrgS5jdUdH94+CBBP0I8rcF0ErW8rdV2V7ljIaf5BZnVM6Pd985OejjWzUBb8j6Pw7oq
         c3fCJztz3Un0KpXgdceQ+QuV3l3hjk8E/cVOlc8o6NPttHOn5EYwzoCppARMYiO6p5aH
         T4plRRMn/fxHi9hRX1f3P+Pd7WQnnZDvFm/VTQm/T6Msm1wYgqd8WDUev2keDkViRjiH
         54GK/R2V74VmfzcoqjtJ0bdrNlR4hw81m6R1rkvnBPy3cogPwWLvIxXRXvRmmuOT+bw0
         DTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=wMblIadmu9KQcO5zsoe8cd5I4mzAPI5XN2P8ppPY1XY=;
        fh=DIDSZ51KI3PEGDtVWUJSgBTFg3hB1ySTK7E3w2CKQw8=;
        b=r5hdlrd9tqBCj76svc0jOyJnbATUTw5W7hdk1KM9YFApIcHmjQK6U6RvBD0X7PAoA8
         tao0k2EscXvr1lvB4orIKSpiR12qz4OsD4ibKv1xdKY+Z+587Hajp7llHYdQR5P3kB7w
         Pvuae2wHQ4l+EbrhGtLKwycN/i9hja7BO5uutXeKGW4lG+2fLUCMhYPHxnds2jm1Vnpm
         Ayj8AWrtfovPiEpCOWNFuFgIjzqZv80ySak94fguIBcNbkq6dujRjqXQEtA5zITbFkWj
         rHCnWTVs5JTRsNe+oKna9UMLGfEgbSDjZ8L0ckcBX4alF3JDoZbY6SsfkanfNuJGdnbi
         VUDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795155763; x=1795760563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wMblIadmu9KQcO5zsoe8cd5I4mzAPI5XN2P8ppPY1XY=;
        b=ipxNlIEi2lEy0KOZ5dETuTCYJg366roKjUvmjW5w7+gLgn5cto0SyS7Yt8ahMJFqls
         wIzK1hZ06eB71j1J+ApGxxm4roFfcoLEHg3Xsv1zRH7y2Sb0ugYttFmQcXcTMEgjR0SJ
         1BvoR+Lm5bCG1LvEvhL6wOesRnP7nceO/1GdyK3/2bqVhB78jHYrIc1lV3aHxau4fGF+
         W7/KMlQAggbSBBwoDPULUNdjPnjFBg6ntXLz5Z6iWgEg1bA3njWvdCy9YcTiYzJZHaAe
         Dv18mBxpkxWapSjeNx7r/hoBUa8sA52emWcpsXgTPVmpFO9sikrEcOAvmin/tLLKa74U
         JwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795155763; x=1795760563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMblIadmu9KQcO5zsoe8cd5I4mzAPI5XN2P8ppPY1XY=;
        b=zSEvH4DHzlvfEAgtU1INKC1pSycBtYgIyQ8JRmxeLSFnrgpQVYbrcv9dg+MQt3OpGw
         xSoURndKyKdz8dehd4CQ7blVXwmzuhQkTwaSlCYOMOc4flep+1kI2JG54Gu+1q5sXadO
         +4HKXri47jpN8Fn2b0/3TgsHav31TVfZ6EFPH2Dq9uK8DSVWsX0Kp+BfvvIFPalZE9Er
         6y++3yHMbXUubQP23r9qwLrPaHs5o1mdxRiixf4u44NKNKqKUKtUB7fX+nLhaLwX58m0
         +IBIJb+OM3YGTpt7F3Wy3OaVwWN4b98TnU8rXj7OUViTamsSBosZ5+I2n0mNHB9fjgrr
         btTg==
X-Forwarded-Encrypted: i=1; AL+hErFELbAhqjFG6vddH1VkLvPwAeE0qcyXp5HdJNWspO65FsCY5hYTX8rUvVmP6r4Zkkn9hwIJSSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CJTBT/oVfjMDV7F5TpQWFT0UokxKTHyGxSeHYA2+eXah4T3E7
	fRhawvNybpyazm3vUmZcHmnLFAVjFBxOZ6u3B3Xix0Bj9BDehIXdSNVurvtbjuUfvfwmntn34M5
	sPfMvUywsgJ2/pzwZ6lRuuA2B3G0xnrN01Sokc6w=
X-Gm-Gg: AYBFou2tF1iRIGIE11Zv7K+u9u+vQRCVfE3xhJbr4zkUU2o5BleZsH6WmPLFCsIwzeZ
	MY3drGSlPXa9LicgSSnkOJzYJayWQtal6SZ1zpLVmjcCFh8hUZzL3j0PdyBDmCYYIG7Mj42+Jm4
	FS8rQKqb/BjkNCDZ8+Y3eMpecYiCgGrY+piU+U+iU6qHF83mfquKyETN6g43sJ5FKlPCZOREs7V
	JbZjD7CBuwfRv4V+eaRo6mqTbMYYPK71hev3AZWc/mu0bCCa3e6uVFFujBTpwJIp9Ke+8hRl8X/
	HVQ4XHMtdK2GUt0tVJsgoX0o5APzRg0/2G/GFXcKiLFra6hNIA5dXSqEKU1Xz8gAKa1hxPpCng8
	13pEqD1lrHZjkhBqRGlMTOhPU9JfqlzVRpZHyzZDfWfTh5mly8Jlr8dyl
X-Received: by 2002:a05:7022:296:10b0:1b4:facd:5311 with SMTP id
 a92af1059eb24-1b5524972dbmr2752866c88.8.1795155762557; Thu, 19 Nov 2026
 22:22:42 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Nov 2026 01:22:41 -0500
From: leograntquinn@gmail.com
In-Reply-To: <20261120-ceph-readdir-name-max-v1-1-ba7c434d4733@clyso.com>
References: <20261120-ceph-readdir-name-max-v1-1-ba7c434d4733@clyso.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 20 Nov 2026 01:22:41 -0500
X-Gm-Features: AclHuK9aDHcErXaQl6fWrFU0u3MCNdahpTMNdkAWlUX6WFPxn46a_0kyYeRPgjw
Message-ID: <CAK8psm4BqmEPnhU8piRoZ2ZkJ9NVNtw=dka4DuL18U9j+A1wPQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: reject MDS dentry names longer than NAME_MAX
To: xiubo.li@clyso.com
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Milind Changire <mchangir@redhat.com>, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiubo,

Thanks for the patch and for the Reported-by. It covers the four sites
as discussed =E2=80=94 the two reply parsers and the two copy sites =E2=80=
=94 and the
approach of rejecting overlong names at parse time so =3Dn builds fail
the same way =3Dy builds already do looks right to me.

From my side there is no need for coordinated disclosure; I am fine
with you posting it to ceph-devel and linux-kernel as planned.

Best regards,
Quinn Grant

On Fri, 20 Nov 2026 07:40:16 +0200, Xiubo Li via B4 Relay
<devnull+xiubo.li.clyso.com@kernel.org> wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>
> The MDS reply parsers bound a dentry name only by the remaining
> payload, never by NAME_MAX.  With CONFIG_FS_ENCRYPTION=3Dy that is
> caught later, because ceph_fname_to_usr() refuses any name longer
> than NAME_MAX, encrypted directory or not.  With
> CONFIG_FS_ENCRYPTION=3Dn, ceph_fname_to_usr() is a stub that passes the
> name through, so a buggy or malicious MDS can hand the client an
> overlong name, and two fixed size buffers then overflow:
>
>  - ceph_readdir() keeps the last entry of a chunk in
>    dfi->last_name, and the next READDIR request copies it into a
>    NAME_MAX + 1 byte r_path2 buffer without a length check.
>
>  - a dentry created from such a name (readdir prepopulate, or the
>    LOOKUPNAME trace) is later sent back in a lease message whose
>    front is sized for NAME_MAX bytes of name.
>
> Reject a dentry name longer than NAME_MAX in both
> parse_reply_info_readdir() and parse_reply_info_trace(), so an =3Dn
> build fails the reply with -EIO the same way an =3Dy build already
> does.  Also check the length at the two copy sites, so a long name
> that gets there by any other way is refused instead of written past
> the buffer.
>
> Fixes: 8f2a98ef3c1a ("ceph: ensure d_name/d_parent stability in ceph_mdsc=
_lease_send_msg()")
> Fixes: af9ffa6df7e3 ("ceph: add support to readdir for encrypted names")
> Cc: stable@vger.kernel.org
> Reported-by: Quinn Grant <leograntquinn@gmail.com>
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> This is sent privately first, as a follow-up to Quinn's report to
> security@kernel.org.  Please let me know if you see a need for
> coordinated disclosure.  Otherwise I plan to post it to ceph-devel and
> linux-kernel (with Cc: stable) in a few days.
>
> On CONFIG_FS_ENCRYPTION=3Dn builds a buggy or malicious MDS can send a
> dentry name longer than NAME_MAX.  It then overflows the NAME_MAX + 1
> byte readdir continuation buffer and the lease message front.  This
> patch rejects such names when the MDS reply is parsed, and also checks
> the length at both copy sites.
>
> Tested on a KASAN kernel with CONFIG_FS_ENCRYPTION=3Dn:
>  - without the patch: FORTIFY reports a 512-byte memcpy into a 256-byte
>    buffer in ceph_readdir(); KASAN reports a 512-byte write in
>    ceph_mdsc_lease_send_msg(); a 256-byte name already makes
>    ceph_encode_filepath() read out of bounds
>  - with the patch: readdir returns -EIO and no dentry is created; a
>    255-byte name works as before (listing, readdir continuation,
>    lookup, lease renewal); readdir of a 3000-entry directory with
>    several chunk sizes and fsstress show no regression
> ---
>  fs/ceph/dir.c        |  5 +++++
>  fs/ceph/mds_client.c | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index c7e91f53e4b6..eae177dd5bcf 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -460,6 +460,11 @@ static int ceph_readdir(struct file *file, struct di=
r_context *ctx)
>  		if (dfi->last_name) {
>  			int len =3D strlen(dfi->last_name);
>
> +			if (WARN_ON_ONCE(len > NAME_MAX)) {
> +				ceph_mdsc_put_request(req);
> +				ceph_blog_exit(&__ji);
> +				return -EIO;
> +			}
>  			req->r_path2 =3D kzalloc(NAME_MAX + 1, GFP_KERNEL);
>  			if (!req->r_path2) {
>  				ceph_mdsc_put_request(req);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 15df9d22008d..3c1ba94fc621 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -450,6 +450,8 @@ static int parse_reply_info_trace(void **p, void *end=
,
>  			goto out_bad;
>
>  		ceph_decode_32_safe(p, end, info->dname_len, bad);
> +		if (info->dname_len > NAME_MAX)
> +			goto bad;
>  		ceph_decode_need(p, end, info->dname_len, bad);
>  		info->dname =3D *p;
>  		*p +=3D info->dname_len;
> @@ -526,6 +528,11 @@ static int parse_reply_info_readdir(void **p, void *=
end,
>
>  		/* dentry */
>  		ceph_decode_32_safe(p, end, _name_len, bad);
> +		if (_name_len > NAME_MAX) {
> +			pr_err_client(cl, "dir entry name too long (%u)\n",
> +				      _name_len);
> +			goto bad;
> +		}
>  		ceph_decode_need(p, end, _name_len, bad);
>  		_name =3D *p;
>  		*p +=3D _name_len;
> @@ -6332,6 +6339,11 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_sess=
ion *session,
>  	lease->seq =3D cpu_to_le32(seq);
>
>  	spin_lock(&dentry->d_lock);
> +	if (WARN_ON_ONCE(dentry->d_name.len > NAME_MAX)) {
> +		spin_unlock(&dentry->d_lock);
> +		ceph_msg_put(msg);
> +		return;
> +	}
>  	dir =3D d_inode(dentry->d_parent);
>  	lease->ino =3D cpu_to_le64(ceph_ino(dir));
>  	lease->first =3D lease->last =3D cpu_to_le64(ceph_snap(dir));
>
> ---
> base-commit: 6a9830a8f414d3830c584782568d0233be969d09
> change-id: 20261120-ceph-readdir-name-max-369df189af6e
>
> Best regards,
> --
> Xiubo Li <xiubo.li@clyso.com>
>
>
