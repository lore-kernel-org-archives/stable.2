Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.153.242
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795663864;
	b=mor3uPHrY84Ag9uXNyFA5Hi+925ISLMukepRl9vUuuKF8xJsNo3D0ytXzSnVDai2OvKs
	 oadFt1jY1iSv9WgrZnKlMOFdW4ploRCL6eTwdd8Vvs2wnfWevvYGrf47Rj88NJrnoHyik
	 S9mYqMuL5dr4wBfFeSoouJGvEsGYxoj3kOmZmJskTPEMh657txZdJJHoVbtiVRhrjB9Sm
	 dbeKPwtA+4qDwxkkZ67arj5CI7xCG96FMr8DEii5oSoSNukTHYCEdRVwjRty1o5Niy2sO
	 X5RMoDpAyZ15bBxPUANTU8CKUB7WNwHOTzlh/yVA+z0BwVcWFsU+kjRnDLNUieSIbLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663864;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=N+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=;
	b=noQgzPfhEWBQlyX9FBUEM5A0I0kE2LjVyoObhpBaAW/lr6Kwqjg+w/WbEAYb5ZMh4SSk
	 bSXBTcyf9Psi3lTeTcorOcIC9bPLJ8FuZ2FX8zL+HpEFigNtKRZizGvB+5D3AkpWvuMhL
	 1DPem9oOCQqezVL8Tmwa6InQjNbBOaybW8aTo9X+CbWuwLBvvIezjpvz9N6FBZyGmErmW
	 RjTDJLKdQ58ZPYolrt6dLuphXY+h+PW7WjCqEhG/Y+JkPLOYBj1EmrzbCIPafy2wNL/KQ
	 n/HI/aVUgs/VprL7tX3sJGBb7ZkoOBNNDUzLwPV2boWvmsd4RpvtA300LbB8RWydYFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=COd8mw49;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=JiuSLZDI;
	arc=fail smtp.remote-ip=67.231.153.242
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BE606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 553BE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=COd8mw49;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=JiuSLZDI
Received: from pps.filterd (m0562594.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APNVxQA259585
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=N
	+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=; b=COd8mw49C9yb8fluf
	eIy7xKCBDO2NqfQ6VAl1RZHBzlf3A8FWyBtI3QxWFYNXNWK75UJvvtc7WdlZ1IzN
	ER90msZ/mgmPX13hDztWwhQhgTZAaeDPxvEGwJ5v6lcUUP7NQoNQ10EMIznCVmWn
	LyC7TFQf6f+c6Gf8fjBcklYPSlrNRmr0kGQYalOnkV6wCDxAZO75UbPrcv24KW1D
	fGJurblv5FqeYMvRTWR++vxeUGMg3UkbZIovuagYiuGAzqaMCE4+8wRcoF2yLRaN
	ocn7fTwSIEMocOHL9pSTNoaoB5kEeXupx5YwAHVqcXLhow01S2zYSYc01cIrZ7im
	+jwHg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4j69e4t417-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:31:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-383ec96a7deso7031402eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795663862; cv=none;
        d=google.com; s=arc-20260327;
        b=XOsFBNSVl8S7J7WqhIci1nwnMh9SV+tcyGRWwf/p07F8sWUkb2xjQHw8rcGqOL3pB9
         uIyUvTBFkYEGVdBILTi+zwuYdlkWa25ceOIGbBo8g4FoKNg3VtNTM8Ng9Br45kttVyIy
         AHdJ1NQZm6QQgmJVgIheN/diBt1OvgzWFrTLHqi4msfrSptJqHCUS0Pn8zpRPoIoQlom
         bAXofHrWntAHSt2Y/6L/sMvJ5L27+wjP7N6453L5eUneTrYfu2nTioHdAYIXdCiWNb9B
         mOiD54TmTmPiyn4/13IopDBXryAmw48j2n+TlXptYrOXHIoo/K9BMn7FDm/BE8AHNI9U
         fFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=;
        fh=T1HUE/LT1NAZG5GxzF58NK+O5V4FsLKSxvlScHTRBx8=;
        b=WU+j83q/oY/pUPpsDz9PS+JEJGOMl5vwCYNYMkDleZZz07MdaTHz/X0McLmK0Q4XiB
         Muf+BrZF+uA4GVFYG/+ZwgEy9UTmxb4dXyimuRGD8+caG+ZBCeskgDmMDGMpdEKMOqun
         70WYn6tcvJWcce/R+r8pTbO4PeUcxv70NOMfwT8YMGY8eCqGyjd6JQx5suSLCAundjI9
         Pw41IHn8v6Esmb0O7YAt2IgwLmo735kKf9Gw6jYpVBNc0imKNv4r190Z+La9J5mc0zQX
         pyss37zbXEtyW+VWvlfn5Ma1hnMX53FbeIr/T+8odl0ZdUpel21V2CxDh1bFN8BNsGNW
         Srpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1795663862; x=1796268662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=;
        b=JiuSLZDImeXzsqgLNJRNnubrt/KHtLo+zGC+u700XKldyjRDyaauQv0cvlJ6SWaBKn
         q9y5vmDFMZQDa5P6gqtCrGhtvTxcUl/yUTYSPwnq7zZJEK5BBElpXeoKok4F/Ks/Sa5E
         7wN5aOOrALqravaHGYmt8TFat99+3aML3njfkzmcmxMaMHneCmQUagYp7xrkw9DRZf3L
         BUwINFVvQjIblpglMLi+yxVgWfE2ICRIW6bOvG2l3hDzUjD3Lc2Il18ndBxHWglpBZnL
         sSo2MewM7TRYrhPigOUejjzpzDKEH6oj3dSxG+KGaLIJxpGWpUGDQAL/5QIdBlkrEja4
         M8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663862; x=1796268662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=;
        b=f860vcq5o6NkXbi18Mnkaq7gGeBk2fxLO9AwanEDE/kj0Pi/wtk8oUs8YIg745l21V
         KjagOMRdJBcyzqP3DRYZZ8KkUdkUutZo0UNhX/WX5KtzJwh1tQRWNf1vscd2aNDnbGbg
         DHvn73Gp1470UkRm/yXjjWvRCj+2/ATES5Ekvja3rS1UVPT1+TmIh4N02wbNFNHDSfeX
         03EBfVX3IyfABnESNsd11OUTCFfniUBHFMxlZ9UetuWWBj9y+mrYaZx0QhpeUnh/NqN3
         yserue33VzEbVkRmBl4iI5QkcBk+VHxsSWW4F8i5dz3XCVh68dgDSWM5GKyuStHreYxE
         nMsA==
X-Forwarded-Encrypted: i=1; AL+hErGdW6D8+dNzOiOe0YqomW2GpVqxJ6y9HCu0cc7prRYZwzwrzygZQzPu/ue68UlcBTeLfEozXyE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A1ZIMfeamQ/KzcWg89s9j4FEbpqv3RFfLKlg62H5W75T6qaG9
	QZiCV6pEfvjK5tG9WE7q6QHmgpZm2y77EtFJQ5m2jlCaAhIsEj/OrmhytVvpmeIjQrKQ8A7Cepk
	kHSkIZOqJ1t/pBa2JmFwVbbEqCWd8hscLSIvAyOJp84GrXZe5sy7+0giRiSOfwVxw0Hdn4L+PNM
	85xenS/7Sx5xKMD7pnmBWjQD9QN0eqag==
X-Gm-Gg: AZFdTZfJrHj8vWu1aZ0Sa1uJjbri3jzf1pBaVXf8YDkbIqj61drp3Piqhti4teSpZbq
	z4iPELfBCnI8k/EodkLW+4V23kYuynXM7x+RgUZ/Ub0eoOL0+iNSjqiFhNWYkt1XN/MfPYT2XPK
	M4ql3OBxMNM4gk2EJXQ8p5zk/j8SmCbGoPWysKNnS9sDXhyN1+dg3kA/uNLw==
X-Received: by 2002:a05:7301:391c:b0:384:df31:69fd with SMTP id 5a478bee46e88-3856fb6a672mr23198238eec.14.1795663861912;
        Wed, 25 Nov 2026 19:31:01 -0800 (PST)
X-Received: by 2002:a05:7301:391c:b0:384:df31:69fd with SMTP id
 5a478bee46e88-3856fb6a672mr23198198eec.14.1795663861013; Wed, 25 Nov 2026
 19:31:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123050440.223436-2-kj2864@nyu.edu> <20261124113412.2078323-1-amarkuze@redhat.com>
In-Reply-To: <20261124113412.2078323-1-amarkuze@redhat.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Wed, 25 Nov 2026 22:30:49 -0500
X-Gm-Features: Aa3M54o04nhg0P2_1uYOfzaZLCGV6LCP0jYuR67VeYdioWcby2Gl3ug3k86xqRo
Message-ID: <CAPqbLS0EbbsQ6Z8P_vep-nMfDKbe8S9cKiOS5fWp8qQdFTp_eA@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: Use unsigned types for snapshot split counts
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubo.li@clyso.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        co+408fcc361565713f@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ABDQWWvajQTL5y6M1JyLvjD_LCI_l_f_
X-Authority-Analysis: v=2.4 cv=KpnYSmWN c=1 sm=1 tr=0 ts=6b07a7f7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Ea0mjXp3HgiUWvWh_zl4:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=GzGT0hU59dN0ITKBXqQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: ABDQWWvajQTL5y6M1JyLvjD_LCI_l_f_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAxMiBTYWx0ZWRfX5G3Zgg6Muq+O
 BRzwsCDSmHiQvX+h1JwMw2Ckulxn97tJsrnMpGsaP3Xz+tYVM98OSKlPx1IDlb3lchlTW/Gk9hj
 71IbF3M8RwWZl1gePkbvbXi+gIh+6M/CX8wOoZZsDEJRoEiwz/9Ih3Sv4UytfwTddLsoJRpPYQl
 D7Rml9pGLAgTMgY7djBPvy2hn3yt4kxyWmbYda4GRwnHLjoVCjpJREMZD+ygSxylaB0Ipz2HYr1
 Xl4ZZHPmVEnCGu56UIyiVPSZSvwALF56+nfImcMO/C6yAbicfgvhEvi7T/uj+O3M1V8IBmzbMu6
 7r4t4qhnbVwVv0jtqF2TxNGWQqMRWyXnlcWmdnNXho+mQwUcLAoK3xvwsH1Acy37xs+y9YHbJGx
 Of9DJg8fZXNZATFAIbTXT9RVjtx1F6Yp+71CjSMdeorwGNwFWKiwLlcyPOaRykdnPf2CuKiKP9U
 iarKkjAqIZ3VrJjUj+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAxMiBTYWx0ZWRfXxUO3FDTaTB1M
 fUnk8TNghu1upNEQNXgkQQQxKylyTa8B2Uj+Hx3pIivM3DzLgaO0/Y1FANA4waFynDS4524VZ3k
 Pl8YUZs6WpD6Io9/A4OblZ8EfRekNu0=
X-Orig-IP: 74.125.82.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260012

Hi Alex,

I've looked through your request and created a new patch for it.
Please tell me if any issues arise or any other changes I need to
make.

v4 has been proposed:
https://lore.kernel.org/all/20261126032756.265377-2-kj2864@nyu.edu/

On Tue, Nov 24, 2026 at 6:34=E2=80=AFAM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Hi Kaho,
>
> On a malformed SPLIT, the failure path calls ceph_monc_blocklist_add()
> with snap_rwsem held. If the blocklist command succeeds but the subsequen=
t
> OSD map version or map does not arrive, cached snapshot lookups can remai=
n
> blocked on that lock.
>
> After the blocklist call returns, ceph_mdsc_close_sessions() can queue a
> close request and wait for it from the MDS connection worker that is
> running this handler. The worker cannot send the request or process its
> reply until the handler returns, so with mount_timeout=3D0 the wait can b=
e
> indefinite.
>
> Please move the blocklist/map and session-close waits out of the MDS
> connection worker, and avoid holding snap_rwsem while waiting. Keep the
> client fenced, prevent further stale-context submissions and account for
> writes already on the wire before releasing session authority; retain the
> required references until the deferred cleanup finishes.
>
> Thanks,
> Alex
>
