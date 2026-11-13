Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603352;
	b=OTaOvLgJV8Yz3X0oeES67FXM/0TXvcdgMTKyucHWX5orKIVV8pdSIWgcKCOySh7BF8qw
	 m9CcUVW+hxDfALz2PC06Sz2bDwbeCBoyzyimvIHSc+dPLRnuvO6odna1H50qdMKcrLPO8
	 wwo+BHtuEfjp0NZeuMQDbHmiOyAQniqOYUmcExusCn/cmZ0y/BpPm7dq1xa67CJmlE4Gl
	 zuC8ySmUIoI3M2l1PX6gIHHHjvL+hudcLJ+rTzJqxGdRHCZkln6iM7y1A7lJSStAKmSj+
	 HiFL1uSkOIAiBEod8o7hkLOSqU8Ss1gtNsPL5mrHTBOtxiEhsdp4kyUTHZgRkzbUjuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603352;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ftJY51c2OAWb/isSz9clJ9j210Y5VcK5eGTyPspyp80=;
	b=JD2ZSZ0aLZ8C4gEkgeiDCBNJcblz5Dgk6C4fzeHLIRIDrqYyZlJxP+NRGPnylj1TJMY4
	 Du05GRRbxrjivPxdwIjnvrnZYbegoMlf35WBenS1btnh5IyX/+EZyVAwMT6oykai3WAyf
	 l0PNkfnNJcLCFgJ4yEysRHoxZcsq2oG9fK0JZla/52tVEkkQ3VRT3u0aYKwcLctbsqiKX
	 7GdHifAihdidRnjcKK7Tw5vC75jerzSaBfrXyw1DNmsIeTvsQjqgdypV/KwuHihXVK1Q9
	 LHeqKTGTsb5dX0g7HZ8s5k4/Aqrg/+Py9WAVXfuCRqVQPaNPlsKV3+29pVf3YitPZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=PCxJGX+C;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="3MC92Y/7";
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A3606A337
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E8A3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=PCxJGX+C;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=3MC92Y/7
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADJYMuv3092513
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=ftJY
	51c2OAWb/isSz9clJ9j210Y5VcK5eGTyPspyp80=; b=PCxJGX+C5raartbiAyfs
	8bSbfri+K1DbGJEX3oYUj3jL1B/84Hw8Gu2AKaMVBOIskR+4kHTpcXXOYVbIWZxQ
	idQEIeOI+i2gq6Zu+bUdgea/qZOteEdOubltcpYZlAE3qKnTpMtMKfvgf7HPFq+G
	1mZYKBOpM+lzI9hPJGWrEkZzZKIDnYEzvd8SMt7NzNFpZaBTRY0Nc6/QH/qnaNqS
	4Sifws52/dbbi3agkCfK+E+KpTsYcxi/maAAAyW9+1yA3wHfysh49x+qbmcrz0c3
	FGrfChqrSK3UgCktrVeFDvLlpb207Nt5u4Z/QnBmEzw7qnKD1KJzYSIbSbOdsimh
	ig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hx5shjh6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:55:45 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91f10c68ccbso35093566d6.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794603344; x=1795208144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftJY51c2OAWb/isSz9clJ9j210Y5VcK5eGTyPspyp80=;
        b=3MC92Y/7ZNMx1+2uZ2/cymOQpE+1eZM4QRiZ5O6V8UQ85h6bn2e3nUvGL5faAdXwii
         eW7vSn0pK1nyGTnoXd4ZNQ5AsSDONyI2goMSKT6pORDE+wifOK6IJ/o1NynOv1uTrs5D
         icdViDHgJrZa/vWH26OgVN+LGd0WfdDwbnFZey+o4DPjDbTu9m4/TsW3a+SiD6CZqA/8
         oFokAG21DBtc2OPNCtevCB5ibg5pQHFJVJk833yzox461e0Y2xUGvVGy1lO7rkdSmRFK
         p8m2a2qqTOpcrQM7T3semt+sgoWj/KHvXLLuGeFZvQzbWRXX8RzaTyX67Abg7pKZjNwO
         +dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794603344; x=1795208144;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftJY51c2OAWb/isSz9clJ9j210Y5VcK5eGTyPspyp80=;
        b=jBxEmGL+WALg/sQJeXLjl1AB23YMPZHBl+L8KjCAEVCG5evDFoQg7s6PLUhBkm/aHl
         pGqc7yufb6LnAfBkFUwmI0B3Kknmeu0pfDGAyBbMPhn7+UyOmdQVCrhHXv1NJhtH81eM
         jKJJJ8yEew8z2G0Dnf9zpvwv0D0aBVFZ6OYEwAKeFwamac8YKTqVP2NoK+L0ln3a+W5G
         r6X16t68tAi48O/r7syWpKulhOmRgU7qk8MfdxlRbyZ0ltuXcMzXd0YyyL+byqStLhxO
         M/4WGGzqIEWBgjQs29JB6w/t0RmWuZork7iT+mgyNBTLS4Z3NOkBWA5HQgVa0P4LcDxm
         Hf3Q==
X-Forwarded-Encrypted: i=1; AL+hErG+X82UJ88pHBY5xqaLEhhy1vzyMB3+mTJypgKOgOkvkOeqXc0i8qZnfQbeoIP36fcEz2Qa2fE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jsw0AnGDXrbHUz8vtGj1whnk7Z2FogRTR5PcFI0UXQA98e1yU
	DdrZS8utuZLazJUrDbCoLxmf1A+1Hvc+/SuZFrzApndciFbKQf4OQVpDiAXTtPhRO9LTTlN2rrg
	/3C4w7O/A/d67QWTingdONLkblyKcSThznld6/E7h1XfRA5M7vQo4Xg==
X-Gm-Gg: AYBFou2e7Ri3hqRp2oP3eSUJhg8TMZpIb4YGR1sSZHDR/DDYJSrO7KS/cmsMGesLTTP
	ztFc9eExxnZEkht3bA3V7m+/QPhKNxJ0yvJxsz5DH9gJo96qeIjc2z9xR+eJ+PjLnvJ8B2+FEV0
	JIV/SLSsXZEVNQ/NYUhJ0liRoEMdBfAYFgLRXHe7uSSAXC75tpi9SVm0zAmMKNrPNPmIW4TpPaP
	Hjg9K/Py65Bt82my7vA+NtQBizGgGrf71sWN+19179dS87YebMc3GpJsJeAGGp63z4N0g6Pif19
	5qgRW9LCC60CxEvPxDXym/m5Wsop6QCVpX+Fr9sIVAW94Pkx4RZ8UliM6bbC2JO/xU8AVliEdoF
	iCCW5er0rADsCesMHVqTP2G37a5XAeTG3M8fY2qXVTN2hgdS5WofsQAX3vQGU5VOEB3daq7WgYf
	o7xYfvzF4EsgYwEZKOpl1aJplIylk=
X-Received: by 2002:a05:6214:48b:b0:91f:2e33:771b with SMTP id 6a1803df08f44-91f2e337754mr31662556d6.10.1794603344114;
        Fri, 13 Nov 2026 12:55:44 -0800 (PST)
X-Received: by 2002:a05:6214:48b:b0:91f:2e33:771b with SMTP id 6a1803df08f44-91f2e337754mr31662226d6.10.1794603343465;
        Fri, 13 Nov 2026 12:55:43 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-153.net.columbia.edu. [128.59.178.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d70489sm28401346d6.21.2026.11.13.12.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 12:55:42 -0800 (PST)
Message-ID: <f53458fd-c268-4dfe-aa99-b050f63af728@columbia.edu>
Date: Fri, 13 Nov 2026 15:55:41 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/madvise: disallow guard region installation in
 uffd-armed VMAs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
References: <20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org>
 <0e3e876e-c3df-4660-ad89-a5f0fd7dedc8@kernel.org> <avcNcL6svEOTg_3r@gremlin>
 <0d6e29f8-54fc-427a-a979-1a8c6f4e3f06@kernel.org> <avdjMNNkOXm2khTW@gremlin>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avdjMNNkOXm2khTW@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4MyBTYWx0ZWRfX001fbsHTm994
 /dl6OPhvhvWI2E2BxGh3ZfC/s5Zi1Gatkh9utpGqfRPbEuN4vCAn/oWGpTTG7E5Eo3Lwe0mgzTI
 d7QlB9OKLRvSbQZYRetUiOw0cOAmaSJkAL+836HImHi0WQT8A+9E
X-Proofpoint-ORIG-GUID: TFB5zHtAwGti0Hamip-e_bcC5TRj9OuJ
X-Proofpoint-GUID: TFB5zHtAwGti0Hamip-e_bcC5TRj9OuJ
X-Authority-Analysis: v=2.4 cv=Ub3E26SN c=1 sm=1 tr=0 ts=6af77951 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=Y+j3KQtDOE8TDC6EXH/Ajw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=H0umD5oqAAAA:8 a=OB121UNARqVzA2KAKi4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=du2hvLAJtKcNxoDMbUSS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4MyBTYWx0ZWRfX7oknaDalkuUz
 K9dEXy9F+1CnmfVcm/28bqa7ett7dyFhroagoqgA0JSfZZ2mwSAcfZu3FYR5oXNKENshYFnKjKY
 0iQZkubScZoVjCHjuNJewYiOGc2XQZ0o3OOIO2N9robuUlLtRYS5GUOthZmuz/mPv4lG/HUHnC9
 4/AP0gX0DgFO/2U5jFTccKe2qSBA1uWlRRAuZKfXRa8eLaUjeHyvwGfQORt4MiPcPuf76KaVCyO
 O86xLAsCOAoz7iSpZQD1srYaPDcnZhmSZoOU1fAaT6p12tEzcALeyb1LljVmvpd7n4JEziU9PdM
 NxtD3yW+ZR5bXkH/Du0ctr/XBHc2Rdb6txqS1EHqrSTDYkPH5n1UakhS0sYRSb1k8IJaE4/1Zj5
 lN1qOLOZ1+ZlDflV9ZcFSUHQ6YnMe3T5POwPQXNpVVXPeBMnbiTo9J7j3DRPJwy+z1wX2EHL2ZS
 rdfe7uKdS4TBBiEaChQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11965
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=10 impostorscore=10 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130083

On 11/13/26 2:22 PM, Lorenzo Stoakes (ARM) wrote:
> On Fri, Nov 13, 2026 at 08:15:34PM +0100, David Hildenbrand (Arm) wrote:
>> On 11/13/26 14:59, Lorenzo Stoakes (ARM) wrote:
>> > On Fri, Nov 13, 2026 at 12:59:00AM +0100, David Hildenbrand (Arm) wrote:
>> >> On 11/12/26 18:38, Lorenzo Stoakes (ARM) wrote:
>> >>> In order to establish guard regions, guard markers are installed in the
>> >>> page tables of a mapped VMA.
>> >>>
>> >>> However, problems arise when one tries to combine this with registering a
>> >>> VMA for userfaultfd, as such operations may themselves need to install page
>> >>> table markers such as uffd-wp.
>> >>
>> >> How does this interact with UFFDIO_POISON markers that can outlive even
>> >> userfaultfd registration?
>> >
>> > The zap clears poison markers, as is standard. It's really horrible this logic.
>> >
>> > So the code path for zap used by the guard install (via zap_vma_range()) is:
>> >
>> > zap_vma_range()
>> >   -> zap_vma_range_batched() with NULL zap_details
>> >     -> __zap_vma_range()
>> >       -> zap_p4d_range()
>> >         ...
>> >         -> zap_pte_range()
>> >           -> do_zap_pte_range()
>> >             -> zap_nonpresent_ptes()
>> >
>> > And zap_details is NULL.
>> > > In zap_non_present_ptes():
>> >
>> > 	...
>> > 	} else if (softleaf_is_uffd_wp_marker(entry)) {
>> > 		if (... !zap_drop_markers(details))
>> > 			return 1;
>> > 	} else if (softleaf_is_guard_marker(entry)) {
>> > 		...
>> > 		if (!zap_drop_markers(details))
>> > 			return 1;
>> > 	} else if (softleaf_is_hwpoison(entry) ||
>> > 		   softleaf_is_poison_marker(entry)) {
>> > 		if (!should_zap_cows(details))
>> > 			return 1;
>> > 	} ...
>> >
>> > And zap_drop_markers() checks zap_details && zap_details->flags &
>> > ZAP_FLAG_DROP_MARKER.
>>
>> Right, my intuition tells me to just nuke that thing by setting
>> ZAP_FLAG_DROP_MARKER.
>>
>> MADV_GUARD, is just like munmap() another form of "zap it all and protect it".
>> >>> This is especially problematic because guard region installation causes the
>> >>> regions to be zapped first, meaning that the removal of userfaultfd-tracked
>> >>> ranges will not be logged in this case.
>> >>
>> >> Again, similar to trying to uffd-wp-protect'ing a hwpoison marker (which will be
>> >> ignored), and then zapping that.
>> >>
>> >> Isn't guard marker installation/removal just another form of zapping?
>> >
>> > I mean users being weird could decide to use it for that rather than
>> > MADV_DONTNEED, but zapping is a side effect really.
>> >
>> > Really the idea is that you might have users who, for whatever reason,
>> > faulted in some range, and now want to make that a guard range, so for
>> > convenience we zap it for them :)
>>
>> I think not just convenience. There was this problem with faultaround / THP
>> placement IIRC ...
>>
>> I'd just zap everything that's there. That's literally what the user asked for.
>>
>> >
>> >>
>> >> So to me this all sounds like "if user space does something stupid, it's user
>> >> space's fault".
>> >
>> > Unfortunately, as per Tal's series, there's more to it than that (linked in
>> > Closes: tags).
>> >
>> > You can get an infinite syscall restart (ugh) if you do this on a shmem
>> > range (Tal's 9/12) so it's a kernel bug that _has_ to be fixed.
>> >
>> > The other bits are just about a user losing track of uffd stuff if they
>> > guard/unguard, as you say.
>> >
>> > But every other zap code path does the uffd remove event stuff, so this is
>> > still an exception.
>> >
>> > If you support uffd, you have to add a whole bunch of horrifying, awful,
>> > terrible open-coded uffd crap, e.g. the userfaultfd_remove() etc. And you
>> > have to drop the bloody lock and reacquire it too and make sure all that
>> > works correctly (...!)
>> >
>> > Anyway there's basically 3 options here:
>> >
>> > 1. do something like what Tal's series does - add a TON of complexity for a
>> >    use case that nobody uses to get behaviour on something nobody sane
>> >    should care about (i.e. uffd/guard/unguard/expect uffd correctness).
>> >
>> > 2. Zap with ZAP_FLAG_DROP_MARKER, and silently lose uffd-wp state but
>> >   'support' uffd. It does fix the 9/12 bug but then subtly breaks uffd.
>>
>> Right, that's what I would do.
>>
>> MADV_GUARD_INSTALL zaps everything.
>>
>> It already zaps swap entries, migration entries, hwpoison entries ... so just
>> zap everything.
>>
>> [...]
>>
>> >
>> > If you're really concerned though, we could go with option 2, which will
>> > just make UFFD behave differently for guard regions.
>> >
>>
>> Not really concerned, it's just the most consistent one for me. Zap everything.
>> The user asks for it, like he would ask with munmap().
>>
>> > (I regret, obviously, ever allowing this for uffd ranges. And we _all_
>> >  regret that uffd was _ever_ allowed to be merged in this state...)
>> Yeah ...
> 
> Ack will send a v2 doing that then :)
> 
This sounds better to me. My concern in [1] with completely disabling this
was that it could break a uffd manager that doesn't control the task it
manages (e.g. CRIU lazy restore registering the memory of a task whose libc
uses guard regions), but this should avoid that.

This still leaves guard installation as the one zap path that doesn't send
a UFFD_EVENT_REMOVE notification, but for CRIU I think that's fine, since
guards would mostly go on memory that didn't have contents beforehand, so
there's no stale contents to restore.

I could imagine this mattering for something like a userspace far-memory
library [2] that registers a heap with uffd MISSING mode. If the allocator
guards a page that the library has paged out, the library is never told
to drop its copy, and fills the page with the old contents once the guard
is removed.

I don't think anything does this today, so it's not worth adding the event,
but I think this limitation should definitely be documented (i.e., that
MADV_GUARD_INSTALL discards the range and uffd state without notifying uffd)
for the sake of the poor souls that work with uffd and to prevent any
spurious LLM reports in the future...

[1] https://lore.kernel.org/linux-mm/f76cb2b0-0090-4554-9169-5cfff6a6ca53@columbia.edu/
[2] https://www.usenix.org/system/files/nsdi25-yelam.pdf
