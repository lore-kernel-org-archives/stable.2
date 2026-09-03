Received: from jasonwiebedairy.com (jasonwiebedairy.com [45.79.9.129])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE843F074A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.9.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469895; cv=none; b=pB/tbqwK9q9oywZRQEdji2h5z18yZsQNwpWmKAEOVJ+/Ze+Wm7boc0fuZ8TxSPVTiEI00tUIgV0waXhJ2HWbZDEt+5dP91C468zlmYWGYIvJ8nPjuMQRfGijxtPoQahPGbT+gQEEAq2dj1QAyV8LANGr/54lrSFwZpCWzsCcqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469895; c=relaxed/simple;
	bh=6V+1BHNv0rXvby/42oduHDy3q8uEde1Zv+oyXE8EZEM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type; b=uimpbp7xDmr75w71gOBJTZP/WXo05qq5UorBzOkfGv4iGRhx27Ax3H8Bav1/cIZA6SkDoXU6vxFdXTKbJrK93fvO3P7BPJZJVhnq1KE1ciUZNxunD2w3XhQNhtZAI8j3dFl4MjWn6VVsnKsdkH8/jmoH4jOu+UHws/liZ3QJMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=benjiwiebe.com; spf=pass smtp.mailfrom=benjiwiebe.com; dkim=pass (1024-bit key) header.d=benjiwiebe.com header.i=@benjiwiebe.com header.b=X7HlPNMC; arc=none smtp.client-ip=45.79.9.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=benjiwiebe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjiwiebe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=benjiwiebe.com header.i=@benjiwiebe.com header.b="X7HlPNMC"
Message-ID: <c26ff09f-48d6-4ef3-9feb-8a8e6d6f37ba@benjiwiebe.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 jasonwiebedairy.com EE8A1C0354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benjiwiebe.com;
	s=default; t=1788469331;
	bh=h5i5c3DfuYwkJat1s1T5twJ9jlLVLzEh+TkSp4TH950=;
	h=Date:To:Cc:From:Subject:From;
	b=X7HlPNMC+eFkkhx9ksxzdffFGVl7c+nJ7xjYN5VLv/J0TuMHhmjCFg4HnfDySRys8
	 /HFMbTev6mLm8BxQJL61BU1F3SwECLO7KM4kyQ1zTQrEURqIkMzXe7o7h3KLk8CZbu
	 j2yDTjNct6k98MsyXIHBnXX7wT+rzg/SkHDA4S1c=
Date: Thu, 3 Sep 2026 16:02:10 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, chuck.lever@oracle.com
From: Benji Wiebe <itsme@benjiwiebe.com>
Subject: [REGRESSION] reads and writes hang if NFS server has v3 disabled
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

I'm using a minimal Fedora 45 VM (kvm) for testing.  I export a 
directory with rw and mount it from my personal computer running Fedora 
45 as well.
If /etc/nfs.conf has vers3=n, then reads and writes hang in D+ state, 
and there's a continuous loop of V3 NULL calls, with the server replying 
that it only supports v4.
If nfs.conf has vers3=y, then the reads and writes succeed.
Introduced in 70b7e3526c53d9dd, still present in the latest 
mainline/master (841e384b841a).

The hung state can be rescued by changing the setting and restarting 
nfs-server, at which point the read/write will complete.

I can do more testing / get more information as needed.

Here's links to pcap files with it working/bugged:
http://grepper.net/lkml-files/nfs-working.pcap
http://grepper.net/lkml-files/nfs-bugged.pcap
http://grepper.net/lkml-files/nfs-bug-kernel.config

#regzbot introduced:  70b7e3526c53d9dd7caccdbeff5b0485640d8cf1

--
Benji Wiebe
