Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A53FD957
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883109; cv=none; b=Trv/C0bbZYEH47KlmTLvJ8XIaSt7mjumfC/o5+kGHlDIv/pGeXtPMpHIhURuhoxWvH94mPmwc8EbxpQDs3IncCX1GRHsgzxU9Mmh6m2DBsUWOG8DUqI72hp+VQlM22yjLCYOkE0yB4Sl7p6uG1i9LSIdYcodFm+P3NnDq4vsIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883109; c=relaxed/simple;
	bh=zirvr5Z+/G/FU1YxpxLmJnWlCOLWHK3ANrDWkR1xQQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=noK1ClxUqzGk3f2L9YJta+MJcdEX5Xwq3HPOMRJtSkdJvXnbF0IwrxqLBn7HSuKfmcZagDIavJJ0bAFPiDAzZIsfkc0nD4R78Aba7xTGfwoiy2PC5Blmy4GJKgY344tidZZA3EZvNbXN54n+3tcEysW58b0om3+N0SplYGHsVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUcyOcsL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUcyOcsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791883106; x=1823419106;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zirvr5Z+/G/FU1YxpxLmJnWlCOLWHK3ANrDWkR1xQQA=;
  b=VUcyOcsLaqz+FJF9dN24E5lWCxUVBuYydxD0M7cRZufgpVAyiL4SVvj2
   Gb/4ukcWk//pZHsptZDaXD1Iy8Nwp3yyL3bEQJdzzk5kkvhgprX01hhCc
   oleaaPl5vVd9N+Pbym61yO/aq+APgWCEXjlyBPg77dKhDbwuIZqkVj1PX
   kpGHP8JnI08KA3jUOGY0UC2RzV8qPOItttjxN8TnVuRWUe2XuJ2pmL3DP
   r94Rt0xtZiMTMAma3Dv0OK8Xg6i1tzhKu3jNLY8lanK5gR7jHrmy1bWgO
   +HF4vVz7WBg5EYAxB7mqZxGNoBya0gJRroVSuae1u+m3rePpqf/XYCOgV
   Q==;
X-CSE-ConnectionGUID: /zTnf53PQvW1ZvkjvFDPoA==
X-CSE-MsgGUID: dfaO37fITwyn66zcGhDCXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="610616"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="610616"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:18:25 -0700
X-CSE-ConnectionGUID: 0Saa6EbsQx2XGqYomowfDg==
X-CSE-MsgGUID: Sbz+hzmJQqiSYOec6g9pdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1214506"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.245.84]) ([10.245.245.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:18:23 -0700
Message-ID: <8d0eb215394e7a285813fe87def6bee358063431.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthew
 Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org, 
 Christian =?ISO-8859-1?Q?K=F6nig?=
	 <ckoenig.leichtzumerken@gmail.com>
Date: Tue, 13 Oct 2026 11:18:21 +0200
In-Reply-To: <2fcd10d5-c1f9-47be-9a68-422f9bbd6837@amd.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
	 <20261007153605.1743626-8-matthew.auld@intel.com>
	 <2c6a97ac21c5ef161dbac279f9b971f383b6b944.camel@linux.intel.com>
	 <dbabed4e-468d-4ecf-b295-f5d8c9c4b263@intel.com>
	 <bc2f4d82-5a8e-4d1b-a921-ee819ca5cac2@amd.com>
	 <992d57f0-7327-4c36-adf7-6dd72137fe73@intel.com>
	 <31f7eb68-6dfa-4ea7-93a4-d4897fbe6a74@intel.com>
	 <3579864a-0283-4f92-b895-5cf399c2ee69@amd.com>
	 <16cfde6b-8881-4ffe-8068-9530286da72a@intel.com>
	 <1a852df2-c2a4-48bb-84de-cdd4b98b95bb@amd.com>
	 <d493d4d1-96d5-4194-bbae-5c1e5d54d91a@intel.com>
	 <5545db90-3365-4d75-9fc0-77dda42b7000@intel.com>
	 <2fcd10d5-c1f9-47be-9a68-422f9bbd6837@amd.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-10-13 at 11:10 +0200, Christian K=C3=B6nig wrote:
> On 10/13/26 10:51, Matthew Auld wrote:
> > On 09/10/2026 14:02, Matthew Auld wrote:
> > > On 09/10/2026 12:38, Christian K=C3=B6nig wrote:
> > > > On 10/9/26 12:29, Matthew Auld wrote:
> > > > > On 09/10/2026 10:26, Christian K=C3=B6nig wrote:
> > > > > > On 10/9/26 11:16, Matthew Auld wrote:
> > > > > > > On 08/10/2026 12:17, Matthew Auld wrote:
> > > > > > > > On 08/10/2026 10:55, Christian K=C3=B6nig wrote:
> > > > > > > > > On 10/8/26 11:46, Matthew Auld wrote:
> > > > > > > > > > On 07/10/2026 19:11, Thomas Hellstr=C3=B6m wrote:
> > > > > > > > > > > On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld
> > > > > > > > > > > wrote:
> ....
> > > > > > > > > > Perhaps Intel Mesa side should use tt-only for this
> > > > > > > > > > type buffer (?), but since this is a kernel
> > > > > > > > > > regression I was hoping we could fix this on the
> > > > > > > > > > kernel side.
> > > > > > > > > >=20
> > > > > > > > > > Some questions:
> > > > > > > > > >=20
> > > > > > > > > > 1. Do you know what is the general story with p2p
> > > > > > > > > > between igpu and dgpu? Is this a legit thing? For
> > > > > > > > > > igpus/APUs, advertising p2p can't be dropped? It
> > > > > > > > > > clearly seems to work though.
> > > > > > > > > >=20
> > > > > > > > > > 2. If this is legit, do you guys then also prevent
> > > > > > > > > > p2p with display buffers? Are you just doing that
> > > > > > > > > > at the Mesa level, or is there some magic in the
> > > > > > > > > > kernel also?
> > > > > > > > >=20
> > > > > > > > > If I understand that correctly that the igpu is the
> > > > > > > > > importer and the dgpu is the exporter then yeah
> > > > > > > > > Thomas is right that definately needs to be fixed on
> > > > > > > > > the importer side.
> > > > > > > >=20
> > > > > > > > Ideas on how do that? Could we do something like
> > > > > > > > allow_peer2peer =3D false in amdgpu_gem_prime_import() if
> > > > > > > > this is an APU device, or further check if the exporter
> > > > > > > > side is not amdgpu, like APU + Xe?
> > > > > > >=20
> > > > > > > For example:
> > > > > > > https://gitlab.freedesktop.org/mwa/kernel/-/=C2=A0commit/7ec8=
6
> > > > > > > c68b42655b4bb85ee90af434a617e7bec8c
> > > > > > >=20
> > > > > > > Is that something you would accept?
> > > > > >=20
> > > > > > No, you misunderstood me. Enabling P2P is perfectly fine
> > > > > > for APUs and mandatory for a couple of customer projects.
> > > > > >=20
> > > > > > The buffer should just be rejected from scanout in the
> > > > > > display code and on the AMDGPU side we already do that if
> > > > > > I'm not completely mistaken.
> > > > >=20
> > > > > Reporter confirmed seeing the issue in windowed mode also. So
> > > > > I don't think it's just a case of rejecting from scanout?
> > > >=20
> > > > Then I don't understand what the problem is.
> > > >=20
> > > > When the dGPU renders and the iGPU displays you have only two
> > > > possibilities, either the dGPU pushes the frames over the bus
> > > > or the iGPU pulls the frames over the bus. Both should be
> > > > equaly slow or fast, so what exactly is the expectation here?
> > >=20
> > > I assume the AMD APU/iGPU is sampling/reading from the p2p window
> > > buffer every frame.
>=20
> That is not possible. The HW can't do this and because of this we
> should have a check for that in the DAL/DC code.
>=20
Couldn't the issue be that the compositor, running on the amd iGPU
blits from the dma-buf rather than scans out from it? And the scanout
is not the shared buffer at all?

/Thomas


