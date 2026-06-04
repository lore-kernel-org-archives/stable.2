Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1147DD4A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580334; cv=none; b=ctRGLOxOtcqsJJmMhsFuzWMvvmAvAqKJh7YijAsy7BUfmTN2iSBBiB3Dvbl4hM4U7D1Q340APQJ7OtQxSJ0YWIputsY3o9wcZsseA6f4dXaiEpW1wg6qW81EGtC5bz2Ux2O8iaFIBI9VimmKBovlgYThaeVoPVGuwL9ImilPGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580334; c=relaxed/simple;
	bh=WOej8V0jS2hif/IqaJuxyEnOwqeHlse8TzLN/1GKs/w=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSgTeNkbll6CII+lTTi0vxLChcqG3xDlFU39YIZ5jDIMhVacwp/1osL2Vq0Vm/xZRllMSlHeJ3CaisJ9KD0STzkUNdnbv513A3Thx7s0fBcPM4SDzRE6SaSjtAnCvHqujxVZekheV4kh0rUI1vdL6rObsXcwsQ/o0tqpu9gpYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5ErR04z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5ErR04z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9A21F008A0
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580333;
	bh=WOej8V0jS2hif/IqaJuxyEnOwqeHlse8TzLN/1GKs/w=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=C5ErR04zPbJcnzhF1uVpb6SpyO0uGcNB1QKenutCnM0FsXMcne4LWJF63unZZ4dQ1
	 /Ol8FyQ4XS57fRII3ZZiQRjcpWCjORPtxXYXsceHTAiinRubrGf09Kw7kc+BEBNKoA
	 k08vdn45OYQHms1brdV0jMJfD5rMbnAXaVr4HApl+CpA5CVv8m39W/SfmHb9vLH9Gi
	 hT1V/vAYC64+l4+qUVvDetMYEieQPCcaSQ6XCVtK+DC65UvzrGMPoIw5f4CLI7GolH
	 iEMdK40b3T3YUwxEuQlK59WjaFgBVjuBid3ASAeRs67jaBSSWFIO0959oSf1rt6PsB
	 XQb9y5NrVORmA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39661f81eacso8950601fa.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 06:38:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9MHr8ERTAvFvJy95Gx9Xxxso4ZdzGVCeFxb4EeZN8PBhZn8S4SFZzgB5Jw6gIyOG+qFYV9pCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI7g0lTJY1UXvzLAPP7fQ5Faw/iyioZiX72gwkgCstruEk1Wnd
	MzgP3IN7N8kpni7O6Ox5cKnpK7sBn9q69FibWHObfwVawRp3p5K+0eX0OwLuaM1ga1mqzFcshg3
	5jBKDoj4gSzjv+es4fJxXzn9JpCDmmhAdUyjsAxDZMQ==
X-Received: by 2002:a05:651c:b2a:b0:38e:94c6:b706 with SMTP id
 38308e7fff4ca-396bb98b98amr9711651fa.7.1780580332277; Thu, 04 Jun 2026
 06:38:52 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 06:38:50 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 06:38:50 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <6j2yk2x23mmtr2xbwkp3ind76qyy3mu7y23psseqqvbjlqepld@n4nsvswt2euz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <ah_3KmASlE44X4Xw@ashevche-desk.local> <6j2yk2x23mmtr2xbwkp3ind76qyy3mu7y23psseqqvbjlqepld@n4nsvswt2euz>
Date: Thu, 4 Jun 2026 06:38:50 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfd6CQO8SLLzP+ggmSYzSwvsxuNUz4rwmT1JskXc_ZAYg@mail.gmail.com>
X-Gm-Features: AVHnY4Jx-zlwECM-UOEsi3xTgeeIQ7EP0o-ZpK4NuYcXo8WYQV9kBKSsNaho8kM
Message-ID: <CAMRc=Mfd6CQO8SLLzP+ggmSYzSwvsxuNUz4rwmT1JskXc_ZAYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] device property: fix child iteration issues with
 secondary fwnodes
To: Xu Yang <xu.yang_2@oss.nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 12:58:41 +0200, Xu Yang <xu.yang_2@oss.nxp.com> said:
> On Wed, Jun 03, 2026 at 12:43:06PM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 03, 2026 at 04:44:30PM +0800, Xu Yang wrote:
>> > This series fixes two issues in the fwnode child iteration logic when
>> > a secondary fwnode is present.
>> >
>> > The first patch addresses a refcount imbalance in
>> > software_node_get_next_child(). When a software node is used as a
>> > secondary fwnode, the iteration code may incorrectly decrement the
>> > refcount of child nodes that do not belong to the software node
>> > hierarchy. This results in refcount underflow and possible use-after-free.
>> >
>> > The second patch fixes an infinite loop in
>> > fwnode_for_each_child_node(), caused by improper handling of iteration
>> > state across primary and secondary fwnodes. When iterating over children
>> > from both primary and secondary fwnodes, the code may incorrectly
>> > resume iteration from the primary fwnode even when the current child
>> > belongs to the secondary, leading to repeated traversal and a loop.
>> >
>> > Both issues are triggered when mixing different fwnode types through the
>> > secondary mechanism, and stem from incorrect assumptions about ownership
>> > and traversal context of child nodes.
>>
>> Please, Cc Bart who is heavily working on software nodes these days.
>

Should I propose myself as reviewer? We can't demand people to Cc random
addresses otherwise.

Bart
