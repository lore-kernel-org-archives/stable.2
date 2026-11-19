Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099690;
	b=FfApXSXSTla4Fej6AkI72NmQi2PoZkwboKd21Jrt6uMFlzBq/CGDSIg7QmgEfx+p5i99
	 NzuRFDXfWXQBJ803sVN0PBFIV9DdhleO3/Qur0W0IGXPyfB4ch01O7lxMYqpqBmTG3Cbp
	 2DwchAVROGXGPtSki4G341lNQxBabLJe+T6Tq1BpgqcZmZzz0qhB3RRZShORbPA8iyTw4
	 YjEtFz5/8NhyTmvXMj3RNIZXChEreHdmvbcQs6Ti53+RKXGYXzsZi4QdFzjI/8yB6rNp1
	 3MCwe5c1wDcfFHpq87+P3NlkAWJAPM44vNw9xJYHSVxur9WS2lGaf7pcRLeLH81lOaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099690;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=gF0elhxDqhfhTK85KNb6HZJYibnUmetNyxlJmNlCngk=;
	b=SOEHxl7oeWv0I7uZrxmAWk38h+iD8BH4sykX58jIBRnfRCsA0LwHiBSLjWQgHPTyldFv
	 7fy8At3C5bmvUX2mdoy/Dot66OGyouPwehjpbHYh89wMNYwucAUrc6Xp2bhwSrePQGZ8V
	 h5+WydwaccCN0vxbzUe1W5ewiPRgJeG+PFN3HqSiiPmwpcN7rkVTGVplBgdEcz34+gWpb
	 LBMHHCLtFj/Y3C0AA4RfbGnmu/RD2c/W7W3EvqJt2I1rYFxYn9eyYLi7ehvqdsUCOoCSR
	 BqEyoyUSKDj4aP0ov6eGXKjwEuCKifZHwBY1cJtWpzlfT1hwNDYDdf7AbFXRVMrLIsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b="g/zZMivl";
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61F606A33C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF61F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=g/zZMivl
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElcLP018017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099661; bh=gF0elhxDqhfhTK85KNb6HZJYibnUmetNyxlJmNlCngk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=g/zZMivltNS1DHQTHNhNsk1RqZkTNXJhNk9/uMhrOlGEa88QX/jPns/IbooxVfB9i
	 aGa1hCZcodsNEs1jprtAaf2KGl6igxc7yWtF84FwfOSeMSghjDMDCgbSTaQpa4jHG0
	 7K+ugqvNRpYdr9FHanKclP/n99hU+demdYFFodXIIc2amHthHt8n8Oz5dPf9XDuLZP
	 B3ZvNgFKfFkYT2Xezu5yAZPIY3lAT5cBbJqpRtBEJg8KyfkjgRDHl6DtrmqGY1D1f6
	 +ArAY77Zaiq19FaFao4lOSIve8PtKiXTaULPfiCxbpnQmvMazCeRBsQrWQWP9T7Dng
	 MwX5Zt/f2wlJg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1303C2E015F; Thu, 19 Nov 2026 09:47:33 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        guolingxing <guolingxing@tju.edu.cn>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Baokun Li <libaokun@linux.alibaba.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: report unwritten extent conversion failures as writeback errors
Date: Thu, 19 Nov 2026 09:46:56 -0500
Message-ID: <179509948724.1938961.17219743708969960110.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101102145.647496-1-guolingxing@tju.edu.cn>
References: <20261101102145.647496-1-guolingxing@tju.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 01 Nov 2026 10:21:45 +0000, guolingxing wrote:
> When a data writeback bio completes successfully but the subsequent
> unwritten extent conversion fails, ext4_end_io_end() does not record
> the error in the inode's mapping writeback error state.
> 
> Bio failures are already recorded by ext4_end_bio(), but conversion
> failures are not. When the conversion is processed asynchronously,
> its return value is not propagated to userspace, so fsync() may
> return success despite the failed conversion.
> 
> [...]

Applied, thanks!

[1/1] ext4: report unwritten extent conversion failures as writeback errors
      commit: 027cfceb35626dc85a24dbf1a8be7e955534353c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
