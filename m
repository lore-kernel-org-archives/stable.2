Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795403799;
	b=Tg6mtkTN0yEpNBe+6SamSvQ0Wqadv0LQts9jh4vKpzR45aWZlGfMC1BtPowv0N89nDZK
	 oq8H3mElPqFZAHsbulzpO7sFly8K7IwAHqRqjLZk6OJrr1QXLAjUh5ZGPXD84St43F11d
	 ObL6gNwnrICn8c9E+cAHKMKSVBi7uQaD13nY4imJR6p3zwvijR2p53yt//+iS5GIbL3GL
	 T6Rfc4qcCWikS49jtIvXRwY+xQ70DVAOmECmlRz//BU6OUPsmlfhkcPWhAin6EZNGRZkX
	 lrs/preP2TLuKFP1KClKdrUtiTLTtruS0eZxMh1xS8L+gGkNSN6ZscFtp0xtBWGYy3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403799;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:To:Subject:From:
	 Mime-Version:References:X-Lms-Return-Path:Date:Message-Id:
	 Content-Type:Content-Transfer-Encoding:Cc:In-Reply-To;
	bh=hMNmEy/NoOizKQ3EVxwc1u9uhogdrN802eAtzB7OmaE=;
	b=fnXWhOPPLZgncQ2gPDKU12sln4OdhQmNWamspeqAFHf8z6LCBYXSBYy8y2gKTKK5u6BE
	 zFO33mc75vpljHAWyMvUyXxEuBWVwC34wLN1SopFVKGtxCEvJdTq6XBiLE7HWjXOLZIOL
	 8d/CdfhnOE0A4JSZ5jIqMlOe5xOOw2O2tJSx9QmbBjjE1Aw5MAJdxfMsE3LS8zsBu4px+
	 caI5KkdIWgBtqdS4YiPv85M0YyIotFvq3gMCdfSP181N7cL9BmaelZrmHQcP1Onv8LsPu
	 0Z1mB0foxH8hR0UUEFS+Rvv40iRwI8hb4Mwt74tESPbR/ttLGVAxjo8LxeQiyJuLI/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF39606A31A;
	Mon, 23 Nov 2026 03:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436907|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00845091-0.000289608-0.991259;FP=675755574188172471|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.k7wtvA8_1795403786;
Received: from localhost(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k7wtvA8_1795403786 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 11:16:27 +0800
To: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: Re: [PATCH v2] drm/v3d: Fix double free of query arrays on parse failure
From: =?utf-8?q?=E7=8E=8B=E5=AD=9D=E9=9B=B7?= <wangxiaolei01@kaihong.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120022828.2612091-1-wangxiaolei01@kaihong.com>
	<3f029973-1a52-4118-acd5-4a433fb49710@igalia.com>
X-Lms-Return-Path: <lba+16b03b008+3a14de+linux.intel.com+wangxiaolei01@kaihong.com>
Date: Mon, 23 Nov 2026 11:16:23 +0800
Message-Id: <e457d7c64cc913174affb10b272225cc3cbe88a3.b0668e69.1f3f.46c7.85ca.d83a1dbea56d@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: <mwen@igalia.com>, <maarten.lankhorst@linux.intel.com>, 
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, 
	<simona@ffwll.ch>, <tvrtko.ursulin@igalia.com>, 
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Iago Toral Quiroga" <itoral@igalia.com>
In-Reply-To: <3f029973-1a52-4118-acd5-4a433fb49710@igalia.com>

Hi Ma=C3=ADra,=C2=A0
Thanks for the review
> From: "Ma=C3=ADra Canal"<mcanal@igalia.com>
> Date:=C2=A0 Sat, Nov 21, 2026, 00:49
> Subject:=C2=A0 Re: [PATCH v2] drm/v3d: Fix double free of query arrays on=
 parse failure
> To: "Xiaolei Wang"<wangxiaolei01@kaihong.com>, <mwen@igalia.com>, <maarte=
n.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, =
<airlied@gmail.com>, <simona@ffwll.ch>, <tvrtko.ursulin@igalia.com>
> Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, <s=
table@vger.kernel.org>, "Iago Toral Quiroga"<itoral@igalia.com>
> Hi Xiaolei,
>=C2=A0
> On 19/11/26 23:28, Xiaolei Wang wrote:
> > v3d_get_cpu_timestamp_query_params(), v3d_get_cpu_reset_timestamp_param=
s(),
> > v3d_get_cpu_copy_query_results_params() and v3d_copy_query_info() -- th=
e
> > latter shared by the reset and copy performance parsers -- free the que=
ry
> > array on their error paths through v3d_timestamp_query_info_free() and
> > v3d_performance_query_info_free().
> >=C2=A0
> > The same job is then released by v3d_submit_cpu_ioctl()'s failure path
> > (v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
> > v3d_cpu_job_free()), which calls the same helpers on the same query_inf=
o.
> > On these error paths query_info->count was never assigned -- it was onl=
y
> > written after the parse loop completed -- so the syncobj loop ran zero
> > times and no syncobj was put twice, but the "if (query_info->queries)" =
test
> > still succeeded and the dangling pointer was handed to kvfree() a secon=
d
> > time.
> >=C2=A0
>=C2=A0
> =3D=3D=3D=3D
> > Every failure inside the parse loop takes this path: -ENOENT from
> > drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
> > kvmalloc_array() in v3d_copy_query_info().
> =3D=3D=3D=3D
>=C2=A0
> Needless paragraph.
>=C2=A0
> >=C2=A0
> > Fix the ownership instead of the symptom: the query array, and the per
> > query kperfmon_ids, belong to the job and are freed exactly once, by
> > v3d_cpu_job_free(). =C2=A0The parsers no longer free anything; they onl=
y fill
> > the array in and record how far they got:
> >=C2=A0
> > =C2=A0 =C2=A0- query_info->count is set before the parse loop, so the h=
elpers know how
> > =C2=A0 =C2=A0 =C2=A0many entries were touched when parsing fails halfwa=
y;
> >=C2=A0
> > =C2=A0 =C2=A0- the arrays are allocated with kvzalloc_objs(), so entrie=
s that were
> > =C2=A0 =C2=A0 =C2=A0never reached carry a NULL syncobj and a NULL kperf=
mon_ids;
> >=C2=A0
> > =C2=A0 =C2=A0- the helpers walk the full count but test every entry, so=
 they put
> > =C2=A0 =C2=A0 =C2=A0exactly the syncobj references that were taken, kee=
ping
> > =C2=A0 =C2=A0 =C2=A0put-count =3D=3D find-count on all failure paths;
> >=C2=A0
> > =C2=A0 =C2=A0- the inline kvfree() of kperfmon_ids in v3d_copy_query_in=
fo() is dropped
> > =C2=A0 =C2=A0 =C2=A0for the same reason;
> >=C2=A0
> > =C2=A0 =C2=A0- the count argument of v3d_timestamp_query_info_free() an=
d
> > =C2=A0 =C2=A0 =C2=A0v3d_performance_query_info_free() goes away, as the=
 count now lives in
> > =C2=A0 =C2=A0 =C2=A0query_info itself.
>=C2=A0
> You don't need to describe every single detail of the code in the commit
> message.
>=C2=A0
> Please, make your commit message for human-readable.
I will rewrite the commit log in the next version to make it easier to read=
.
>=C2=A0
> [...]
>=C2=A0
> > diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_=
sched.c
> > index 1924e3440dc9..6ee64fbacae9 100644
> > --- a/drivers/gpu/drm/v3d/v3d_sched.c
> > +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> > @@ -95,34 +95,44 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v3d_job_cleanup(job);
> > =C2=A0 }
> > =C2=A0=C2=A0
> > +/*
> > + * The query arrays are owned by the job: they are allocated by the ex=
tension
> > + * parsers in v3d_submit.c (which also publish ->count before they sta=
rt
> > + * filling the entries) and they are released only here, from
> > + * v3d_cpu_job_free(). =C2=A0The arrays are zero allocated, so on a pa=
rsing failure
> > + * the entries past the last one set up are all zero and get skipped.
> > + */
>=C2=A0
> This comment is superfluous. Please, delete it.
It will be dropped in the next version.
>=C2=A0
> > =C2=A0 void
> > -v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_i=
nfo,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int count)
> > +v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_i=
nfo)
> > =C2=A0 {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (query_info->queries) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i=
;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;
> > =C2=A0=C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; =
i < count; i++)
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0drm_syncobj_put(query_info->queries[i].syncobj);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!query_info->queries)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> > =C2=A0=C2=A0
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kvfree(query_i=
nfo->queries);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < query_info->count; i++) =
{
>=C2=A0
> Stop the loop at the first NULL syncobj.
>=C2=A0
> if (!query_info->queries[i].syncobj)
> =C2=A0 =C2=A0 =C2=A0break;
It will be dropped in the next version.
>=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (query_info=
->queries[i].syncobj)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0drm_syncobj_put(query_info->queries[i].syncobj);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0kvfree(query_info->queries);
> > =C2=A0 }
> > =C2=A0=C2=A0
>=C2=A0
> [...]
>=C2=A0
> > @@ -915,7 +885,8 @@ v3d_copy_query_info(struct v3d_performance_query_in=
fo *query_info,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct drm_file *file_priv)
> > =C2=A0 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int i, j;
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0query_info->count =3D count;
>=C2=A0
> Leave this in the functions that call v3d_copy_query_info() and remove
> count from v3d_copy_query_info()'s parameters.
It will be fixed in the next version.
thank
xiaolei
>=C2=A0
> Best regards,
> - Ma=C3=ADra
>=C2=A0
