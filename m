Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BDD3101D0;
	Mon, 13 Jul 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933296; cv=none; b=Z3O+hlOP1uQ5Sw++EmdW0Wq3hAFnvsjp0I0JePAPBMbTjEGLy5bV8wBZ7+MKBxH/ig9NCasEoiX56swxMP9idWaqrMqvA/Zr4rpIs3gL6KBFZCGZji5aVdNRdDwEDprTBA4tjIrE93HOTP456V+tLNb6duBczlrDJwCjvNjw+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933296; c=relaxed/simple;
	bh=brG4punToi/QVZMcOiAxFIY3tK8FArsXXfXKOAc1Lh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvamSODN5B8zOHxawt1goQQRbO34lf5BuMh0SVVEwy8eGxW5Aava2ENRYAmcR+ZArn7xhYp2SD1MEB3x5l56TFgmKVU++YtB0IT2sAlJNBMnCXy7Kr80wUa+cjsDh20mRHRbDwuNtG4+c2t1M+CEBpB/R0tpyMx2G0U71tbFKEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=FghWGFBu; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="FghWGFBu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783933182;
	bh=BFMvyiC2DCtmPYg5QWCM+o3YaMaFN7Rp9m1r80pW+l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=FghWGFBu/KT/mqxO9CBg92ra28jfl/l4d82Hw8cP/kgJbC76OfebIy6IQuBJSbZsN
	 Inwv1/jKPb/m6HfigoH3l+t+VlHE5MzetcetCGIQkPClXZvdmLAUBnwwduYnKldh5A
	 IHV6dAonM984mEErpGXAxnXXXII7tDKKlWzQhnak=
X-QQ-mid: zesmtpgz9t1783933181t06373724
X-QQ-Originating-IP: PL47oaHtcBmq07klp3P7KVA6E5BJWjci0tMvgqd6WM8=
Received: from [127.0.0.1] ( [36.152.24.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 16:59:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5298362049264850985
Message-ID: <45448501516EA311+ca2ef796-7533-4bab-92ad-ee2dbc4cb003@smail.nju.edu.cn>
Date: Mon, 13 Jul 2026 16:59:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Reject DMABUF pages from the access pin path
To: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
 <CD68F549BF3761B7+20260709050800.520607-1-peiyang_he@smail.nju.edu.cn>
 <CO1PR11MB48356388B36743AE8E083A3B8CFA2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <CO1PR11MB48356388B36743AE8E083A3B8CFA2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Nl7eTg5yGHnwq5BHGlfQ52lnSdLbiyRf5Xc9U1uTQkcvjhe7CKYLk3o+
	YX+miOIT45Zt2Z/d8laqBVuF+BK3usFhzSUxnReRkZFwEP3GMKoW1Ucrr9UgEUz4oh7SEV1
	833MdLdT09LzIq/uCyStJt7T91RgK8fUzSIDVhYz1gX6+xkuuL3kQSLelxmi1W/ipLvx5bM
	ABkCZy76oglFjoKRUDpPEyUYJxX0OVP6u8zOpKi92jB/wGw8zGNG00nRrxo3XsCF5fu2VDk
	z9TUQR20lsLOM8SvTI2Vjb7RZwMKEpQqVMaSQY+gr1GNac6gAiAkaBSfpTzj6TyxMADTuOi
	AFXZMyHkLxwKjWmaRLK4KqAp7aTFNpO6LeP0prwaChmGM3FZQVuGY2IUamBPGJIoi36LhU2
	E+ayVo/tfZ1Sm1puKSPz4kQ+IMoaVWcu2zZxjJCGK/ku016QLYoH7HYnL7rgWiy4BPdb9Zl
	/ir6huh0QCo5Iok0dVsij50svHlrb6hkbnmGPuybmLNghMYq9f04BH0z7jghHEY/2epAndv
	wG76sZQ1Sm2o1OBcQRgM+RMD4/2TPLUe7Wyqu75VVG8QgDeR61uuK2xa+6DOHDxXslfidE+
	2PFZjB7VXZwPVlxZIr/92IxsD0Z1vew2lZCK6tIdKDAMFyW6gXwEiolIq/rcn2PyW8fyGyX
	ep6fLuBcYZqF66wPDQ6NqcWDnlkF5XUACu8wqXsYgbXpmmn1S0/qnDmZKMqjnWShFbV0XGz
	B820XA83QVq8/Xi8yHpw67rpe0RwDVSBgMIYsiOdpv+f9azeoo1grd1nLhLj+Hp/yHTPhQ2
	7iTw2/7a6wq+8SL53PR07bcnkmO8TffyghfzcKjX7M33lgZBLTTSYBF6M2ZXuY2qXOuFVXC
	2GVWoVHruQS8OCibOU/tqEUPzxAUFAqb8Yu/oFDqDlJ6k6tt1D1iEw8IOyPMN2PzEcaxyMT
	woxs+yxwTm/mWY2EFbMpNxg9oN3CdnxGyLibmgaaI0PkC+OBY4LvjYgmySzkbvAQ6dM3cCy
	WzoYHoUk1a89Mg/M8CdB3fAqBWzvDHzoA6225jbhKTo5q/2SBQfl5mKPxADL0wqphdVBsQr
	XPNCJLvqEd8ocf9dVu/YFQ=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

On 2026/7/13 14:10, Tian, Kevin wrote:
>> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Sent: Thursday, July 9, 2026 1:08 PM
>>
>> DMABUF pages are not supported for iommufd access pinning.
>> iommufd_access_pin_pages() returns struct page pointers for
>> in-kernel CPU access, but DMABUF-backed iopt_pages do not carry
>> a userspace address that can be passed to the GUP path.
>>
>> iopt_pages_rw_access() already rejects IOPT_ADDRESS_DMABUF before
>> doing
>> CPU access. Apply the same rejection to iopt_area_add_access() before it
>> takes pages->mutex and calls iopt_pages_fill_xarray().
>> Otherwise a DMABUF-backed iopt_pages can reach the hole-fill path, where
>> pfn_reader_user_pin() interprets the union as uptr and
>> calls pin_user_pages_fast()/pin_user_pages_remote().
>>
>> This fix also avoids the lockdep warning reported from that path, where
>> pages_dmabuf_mutex_key is held while gup_fast_fallback() may acquire
>> mmap_lock.
>>
>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> 
> this is not required when you are the author

Hi Kevin,
Thanks for your reply! Will send a V2 patch fixing this.

Best,
Peiyang


