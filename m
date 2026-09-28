Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE474E66AD
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611998; cv=none; b=XZmWvYf2dzriys+Z7xOx/qyaoRNKxdZ9ppsWpXmP/grhe5O9fdka/W4JPefSw2CEnWNTBGCn3JaseHIiBxXT9Tih/kuj/xGmcs/0Gjnu0kT0c2iaexIZsmvIy3Nu5DiBeja8QAkgd1tpKdUPeebti8Sk0fyZqMsX0s593xbFX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611998; c=relaxed/simple;
	bh=6gtprv+I7d5L3pBHaUUFHArfk9rtSviWLekbvSkYtZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnzX+CKzCmIw7BneDo+MAP0AaoQNwdElYjryBHP1jT/wdR85/s9wASPOmV3mOYFANoLxod7+OM36vLF//9Ns+uE/SdxEx/syDra2m+Fh1CicO2+cUnpYlVpPrxl0LB1/t3r/waPfD5lmEPJ8kaaUcrZx5onAmyO52gPVLk2Y0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eP0QPYhz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eP0QPYhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790611995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yjRvgCo71Q2/uVN+UiK3J2F/H+VV1qWlgtYqAluoao=;
	b=eP0QPYhzYcv4o05Ciflk1JHINOr8nVwMHIZKxz/m6QPrYRh8m1jWyp++26q9usROjjhw9H
	hZid6H00kg6mKM3e7BRiJpnUOt9g0mppIIdEDG7kpDp+ueUNgGItrCfe8dgqK1zjPJnYMk
	eOda5rWU5euAulcYh2DgHJLE3xdCPBw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-SzX7qyHtNEW_m7DoV7sE-w-1; Mon,
 28 Sep 2026 12:13:10 -0400
X-MC-Unique: SzX7qyHtNEW_m7DoV7sE-w-1
X-Mimecast-MFC-AGG-ID: SzX7qyHtNEW_m7DoV7sE-w_1790611986
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9889618DA5C8;
	Mon, 28 Sep 2026 16:13:05 +0000 (UTC)
Received: from [100.91.18.181] (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41E741956047;
	Mon, 28 Sep 2026 16:13:02 +0000 (UTC)
Message-ID: <7e8fa7ac-4438-4dea-b3e0-c142523aeab3@redhat.com>
Date: Mon, 28 Sep 2026 12:13:02 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] cgroup/cpuset: prevent activating local partition
 over remote one
To: Ridong Chen <ridong.chen@linux.dev>, Hui Peng <benquike@gmail.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Chen Ridong <chenridong@huawei.com>,
 cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260924042729.1908863-1-benquike@gmail.com>
 <20260924042729.1908863-3-benquike@gmail.com>
 <93e48fe3-d229-4870-af8a-32431d236211@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <93e48fe3-d229-4870-af8a-32431d236211@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 9/27/26 9:40 PM, Ridong Chen wrote:
>
>
> On 9/24/2026 12:27 PM, Hui Peng wrote:
>> Commit 6da580ec656a ("cgroup/cpuset: Don't allow creation of local
>> partition over a remote one") added a check in update_prstate() to 
>> reject
>> creating a top-level local partition whose cs->exclusive_cpus intersects
>> subpartitions_cpus.
>>
>> However, if a top-level cgroup A1 has a child A1/A2 enabled as a remote
>> partition on a subset of its exclusive CPUs (X2-3 on A1, CX2-3:P2 on
>> A1/A2), and A1 is then set to "root" (P1, becoming "root invalid" via
>> update_prstate() because its exclusive CPUs intersect 
>> subpartitions_cpus)
>> followed by expanding its CPUs to include additional non-remote CPUs
>> (CX1-3), update_cpumask() / update_exclusive_cpumask() calls
>> validate_partition() without going through update_prstate(). Because
>> validate_partition() does not check trialcs->exclusive_cpus against
>> subpartitions_cpus, A1 transitions from "root invalid" to a valid local
>> partition over the existing remote partition A1/A2 and triggers:
>>
>>    WARNING: kernel/cgroup/cpuset.c:1943 at 
>> update_parent_effective_cpumask+0x189b/0x1fd0
>>
>> Check trialcs->exclusive_cpus against subpartitions_cpus in
>> validate_partition() when !is_partition_valid(cs), and add a regression
>> test case to tools/testing/selftests/cgroup/test_cpuset_prs.sh.
>>
>
> Was this message assisted by an LLM?
>
> It would be helpful if you could provide the reproducer as I replied 
> earlier, so that it can be understood more easily and tested.

The provided test case for test-cpuset_prs.sh is supposed to be the 
reproducer if you don't have deadline task running in the test system or 
the kernel includes the last cpuset patch that I sent out.

Cheers,
Longman

