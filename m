Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C1417BCF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798133; cv=none; b=KHv6iqPkfm2e7pShM+Xvj+H1/CfRzfiHDpHRiWwLEHBb1PLw3MCskxycPxajEuEuccVziqx3rkpBNxu1GJYQ0yXupsBXEC4IkMk+ikFyU4orKgRmRoKJze+ftcdEPjBZeMGKm9VH27gfWO1URgtsPiJQQ9Kw7DEMWOIt4jGePFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798133; c=relaxed/simple;
	bh=/r59B+4fbS2XEZA7YWBaen4M7zk7M6FzVG8lMCu5vdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JupoRSZ27a/x009pIwnHc27mEumZqKAstJZ28v87mJFRy48zt7jydjgdVQZQGbhm5Bv8uc9wU29gcCYPflwSC0EhT3fsvntoLBasiTYhfqQdVgRsoQ0JB2AE5gkvoxLoDXRY/4omCHl8gTAYZfqiq1haYMX+1FVdH+9jtdHO9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYEhTiqR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNV2U+O8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYEhTiqR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNV2U+O8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784798129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFDQsWaV4YVMqaytcd/qULKOMwPiXTV9I3KQpj/1PB4=;
	b=WYEhTiqRlpe1bu5fdwDiuxmU8TBupREdCAej0k/He3vq60p3sPvTPaa8Ru4k1N9BLdg98v
	EZFd7sP1FGQgmYQiMLmUfwN06oQtiy/Qj61jN/PhdRYvT1fjaPgroB1joPjzd8SMVslp6J
	7dY9im7lsqIr7u2uMKgagY55cnL3BpU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-oXlujaGcNO2tSLehuDPVgw-1; Thu, 23 Jul 2026 05:15:27 -0400
X-MC-Unique: oXlujaGcNO2tSLehuDPVgw-1
X-Mimecast-MFC-AGG-ID: oXlujaGcNO2tSLehuDPVgw_1784798126
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso4706765e9.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784798126; x=1785402926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HFDQsWaV4YVMqaytcd/qULKOMwPiXTV9I3KQpj/1PB4=;
        b=YNV2U+O8DXMc27VzT143onyvFDSFoL3NCqnbxv4g4BrbI4TWSHuuwqgX2qFOq8n5nq
         tN1SsOrjPHDOFrOBBM/UHD9NsaWHh7eJbmSlTpCf+ATHB+0g3Vr9HeTX6g2O9APoZHai
         oCaDCB2RjgRp388spIWxUA6Vxp1uhWV0kNjkH99O8uy+fj5GKwNMSY7nK15reE3ihMwH
         dCQTbPEQtbuOrWj59XZARyjVU/0y58TdXr7hZyT6DjA6JRcP7ki6kuyPuwEkjkKKa8PS
         EiCPTkCsW4SNMnvnOdCWHHryiDQOJJO+ZGUn1eZz+kC8k/ZELxm607UMw4KC+qznSAER
         Ar3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798126; x=1785402926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HFDQsWaV4YVMqaytcd/qULKOMwPiXTV9I3KQpj/1PB4=;
        b=H8z0WkTth7FunDSWKnfBluwe2GFU/Hz/ZPH/Cj4Tsjl9n32ujSeuWCCj5zSINwAfB9
         eAVcOci7xSc3gxKNUnHmFZEl61nvAEG+BzxOP2PpFb27rRCHq8UYANoZ4JFGKTbTbmAB
         dSYR/EFBdmxlrpCOuZmpwXATQHQFbx4yeqWoKmOilbSGxlI3MvUDrJDleaLTQgvKJJ5O
         qhgNI40bvpsOagqo1UjGoj7+/UqdaFBGWTdr73B/kjN9GfsUwA96jKjOqXRygdHyJqHi
         nEXpYQT8EmKcO+RkMSo8FYZcDBsSuJeLRDy3CIdJnF2wPdozGS/EOo7jeZkwPh2VGcwF
         QyFg==
X-Forwarded-Encrypted: i=1; AHgh+RpccXwI/YPyK22gqzuDmFU81hkOtCd++2Uk6Wd/SSU+OI35lwZa+wzcZugeayHjpgKKl7uLZgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYm1CzqYE0Aq4ISHHAbk5QgZ8598uFRpE3g+hGGcRyiBVTPx1i
	p3tEWUlFxqq2e11V1lQXjkD6aRIvHZDwVP0SuVQiWE5OVIhI7o6Tz+DB93PidPuHIfId7mjrIAX
	vp+vgRAXeEoEiwzCD5qT6fCwuCMxxgNiVZboy6iPjO5iJ9orohpUWlcjRuw==
X-Gm-Gg: AR+sD114ytFUbCteI7iC3vZFEddzGCHRUx1bUibLtTlwf+PIcoVTC+bTDS04ZejdE5t
	W0ZCRySiUwSV9g1ibq1lJ1bg63zEy0weQ96g7e9MpUHXPpuKn7sbKcDZNyOUHeGtWG0vC8v0hyj
	bLoFskKlzo+kcR8KO55zpDu0dI2+YTcyn2xtXX0um3sB56cqKDMPTYi83YXAeEZAR8CK241w6Xj
	LnosluNykkYtRJ//yj68BEYblTTKZ7yckMy/6wW97PQEVA0Bg3rMbmhWiftMrdyCUbi4NFRm+VM
	DImFsUU6uBi51GTiz57vMQYp5DTushsSvmkCvajw1wVEXiHCOCmapo6WwQyIcZGj9maGNVQK0Wk
	9Z6Ipk8oEd6erxFWDYufixw==
X-Received: by 2002:a05:600c:548a:b0:493:eb71:5cc6 with SMTP id 5b1f17b1804b1-49573d0eac1mr23927685e9.27.1784798126333;
        Thu, 23 Jul 2026 02:15:26 -0700 (PDT)
X-Received: by 2002:a05:600c:548a:b0:493:eb71:5cc6 with SMTP id 5b1f17b1804b1-49573d0eac1mr23927055e9.27.1784798125726;
        Thu, 23 Jul 2026 02:15:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b72fac1sm108575995e9.1.2026.07.23.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:15:24 -0700 (PDT)
Date: Thu, 23 Jul 2026 05:15:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, Ammar Faizi <ammarfaizi2@openresty.com>,
	jiaqiyan@google.com, ahwilkins@google.com,
	Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
Message-ID: <20260723051327-mutt-send-email-mst@kernel.org>
References: <20260721005603.1710551-1-linkl@google.com>
 <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
 <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com>

On Wed, Jul 22, 2026 at 09:07:04PM -0700, Link Lin wrote:
> On Tue, Jul 21, 2026 at 5:36 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > hm, now where did that come from. I can find no such commit and that's
> > the second time this very unusual thing has happened in 30 minutes! I
> > wonder what's going on.
> >
> > I'll use
> > 36e66c554b5c ("mm: introduce Reported pages")
> > OK?
> 
> Yes, that Fixes tag is perfectly OK. I pulled the previous hash from
> an internal downstream tree by mistake. Thank you for catching that
> and correcting it!
> 
> > The bug is very old so I won't fast-track this fix into 7.2-rcX.
> 
> Completely understood and agreed.
> 
> > AI review pointed at a possible pre-existing use-after-free issue,
> > related to virtio-balloon. But I think this is a rephrasing of the
> > issue it flagged against your v2 patch.
> 
> I actually looked closely at Sashiko's flag, and to my surprise, it is not a
> rephrasing—it caught a completely separate, valid edge case.
> 
> My patch fixes the UAF on the PM suspend/teardown path. However, Sashiko noticed
> a UAF on the PM *restore* error path. If virtballoon_restore() fails during
> init_vqs(), it aborts without unregistering the page reporting worker. When
> system_freezable_wq thaws, the reporting worker wakes up and dereferences the
> now-dangling vb->reporting_vq pointer.
> 
> Since it's a driver-specific lifecycle bug rather than a core MM workqueue
> issue, I will write up a separate follow-up patch to address it in
> virtio_balloon.c
> shortly.
> 
> Thank you again for shepherding this fix into -mm!
> 
> Best,
> Link


I suspect rest of work items we have, e.g. update_balloon_stats_work/update_balloon_size_work
all have issues around freeze/restore and error handling.

-- 
MST

