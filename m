Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350375;
	b=2ItHHXZY+CPFLt+Ekc3z+cUn60FMsBCHyIbNBpV4JLLOOLChp3Rl8SK9rcw35i6lCwlr
	 +Gs3dQ8mwcoHc25zVpQuhmy2FI8qgg8Z3DHATG9tiJXyuMrafEeHbKvlS5I4cGR65TDtg
	 DkEQ1bXhdfL7czII7KJG4vw96Ctf/rPW0J/Z+sI7ebAkCCuUYqgzBcBomaHY9twDjIM8F
	 azuBqPFXSPsOodObeVwHDAnATR31FfjwXGYogJgAjyImQ/jM1clIvvp4VEpNkTwT/kn1d
	 EOpgEUj9y8q4mtJZvdZoITFFZYG6Pk4GqmtK8HcPzHkPYwZW8eB23QP7Wy3//w951fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350375;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FYw+R4tThY9ijxrPMeJ6bkKz9WbQem7Wim2y25tODDo=;
	b=otrDv3KSsEmDSa7OhjP70YNLOQpnN9hNByZ3Y56u6JjLTA2DKhymm58a3w7cj8pYn1vK
	 g6OHLfuanT+BAqUFmMUPUctb0uFvj7W+Gm1N/O0t4hyx8+p0/pVRed/NVRHAYQSGZ0sTr
	 DETTQlfxbj/x5D50VvwEw65LHfkWrYnkXoHowBpcsbWCMV0QFjDgI6CBZMbn7SrtlPc8P
	 kFbhbvkM2/DIcZm4Sf623VHae8OXZtXL8JyltxHbREGetbQUMk0FcXRGpVDQOjNY/b4at
	 4JBewSBM31DINYetanD1dUMF41MvP2G3VuuDqF+uuwiImGyrPA4rQkBSNzaWS0v52WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=iihKc7CS;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCAC606A31A;
	Fri, 30 Oct 2026 08:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCAC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=iihKc7CS
Received: from cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id A0A651C0043;
	Fri, 30 Oct 2026 09:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793350373;
	bh=q6juWM5f7jikhcMl2i3ywbPNpOJBMHXqoBewrCHl84A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iihKc7CSYD8TVRUP8Uhtr8sZX7SdlWSRlQOevVC+Mm3tmKF/xYwKffgrKG6tvTmgm
	 u9khgsUeHwN+rB5poSBzmqpI2iF2yG6pwXbM18msSILhIOAc8AWl/knEapyijB0XPR
	 o72K1nUEJtO+Og3bI6IoxGZ8Ft/DZTHHQirNKbJI=
Date: Fri, 30 Oct 2026 09:52:51 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/syscall: Return the preset value of
 skipped syscalls
Message-ID: <auRa4xcZpLSQD78V@cs.unibo.it>
References: <20261023180735.853655-1-renzo@cs.unibo.it>
 <auB6vjNg3w5LPVwb@kunlun.suse.cz>
 <auLyYd9-6WwwzPgz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <auNZiOi_tj6ssGZr@cs.unibo.it>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auNZiOi_tj6ssGZr@cs.unibo.it>

On Thu, Oct 29, 2026 at 03:34:48PM +0100, Renzo Davoli wrote:
> I will send a v3 rebased on current mainline, split in two:
>  1/2 remove TIF_SYSCALL_RET (Fixes: 69cb2be898be), as suggested by
>      Michal
>  2/2 return the preset value of a skipped syscall (Fixes: 05c033db7e9a)
>      using your expression.

v3 here:
https://lore.kernel.org/lkml/20261030084926.1068384-1-renzo@cs.unibo.it/

renzo
