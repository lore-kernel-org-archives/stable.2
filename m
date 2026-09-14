Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A805401A01
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401079; cv=none; b=ucMIYjKe1B/wsCwpjltcOli0avRZtxqY5l2OLnejZkcxpg9MySvB/mWU54L6bh7G0/xfddqJVFBrhyQQ9RxIJWt9IaNzw+zvotPacMCIFEt+07Mahs/G/6jnBeDwR9cSvBC8HRFUMQciux1Siq6sEmpoF1h1o4aQBRud9zpPkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401079; c=relaxed/simple;
	bh=rVfAhaMRwZYiEpg6dw/fmsfziMwKNFHeaO2+oHPAsqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH9HFv2+sfhr2cyMdZ4xe2hHYb/qa7UQYamkSi0Om4joH7LX7YqXmPEuSc9PQtjva0y7BxUr/82sK7sshOwDCyoLOclY8DL4HBkScjyq3uMlfLSbQKM6u3amzeA4baw32BfgycVipQpVBuS+Yroc1U2D6R9SQB3vgQ3f611vfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvkEjmam; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvkEjmam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789401077; x=1820937077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rVfAhaMRwZYiEpg6dw/fmsfziMwKNFHeaO2+oHPAsqk=;
  b=bvkEjmamEAGiSn2WPDjH8SKb9VsGO3eN8L+5lYmm7Bf31eXra+baTs6T
   TgAOR8xB1fVJRPzabbO+wOM+gEyB9Bhwuvt2/Ix5EBUBFmLgQFAneJiKS
   cjfi85T6w5Wbxyx0kXPA85U2+Kh1zEXLp4t23/q7zjxOSYtKxoBA5/aCl
   X43shRJuwMS36oYoRO/51zYdms3Fkp25hZ3BzRyUgXOTLJMEgcyRvQNCq
   1VA3H0olypZ8C8dcNjM1BtKJOtyPgfh3hyEqrAUcszi/dZBiA2yxx8qDi
   5Li27O75onPEKBqZE6nIg7VHJsCcB6P/CTwHRbmZvvFDLDcF4M1jcvuf1
   Q==;
X-CSE-ConnectionGUID: hu6OOQKsRRucRTgkN8q+lA==
X-CSE-MsgGUID: entndaM5QDWH6HSQkwdjmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100418145"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100418145"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 08:51:07 -0700
X-CSE-ConnectionGUID: EEFOzE9iQEq7bHmWCZ1/0Q==
X-CSE-MsgGUID: M4Bub+T8SaqqaHzsGTJAeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1072035"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 08:51:07 -0700
Date: Mon, 14 Sep 2026 08:51:05 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 1009/1376] perf test: Display number of active
 running tests
Message-ID: <aqgX6Xsr5GmddTTj@tassilo>
References: <20260912065607.535295758@linuxfoundation.org>
 <20260912065630.052286725@linuxfoundation.org>
 <aqbt2-Kh76GZxmPK@tassilo>
 <2026091402-eccentric-curry-66f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026091402-eccentric-curry-66f6@gregkh>

On Mon, Sep 14, 2026 at 11:51:19AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 13, 2026 at 11:39:23AM -0700, Andi Kleen wrote:
> > On Sat, Sep 12, 2026 at 08:57:15AM +0200, Greg Kroah-Hartman wrote:
> > > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > It's hard to see how these 6 perf test patches are stable material.
> > 
> > They seem at best be nice to have.
> 
> They were needed because of:
> 
> > > Stable-dep-of: 44e82c4d2ff3 ("perf test: Fix skiplist leak in cmd_test")
> 
> thanks,

It's same there, I don't think anything perf test is stable material.

It's just a test suite after all.

-Andi
