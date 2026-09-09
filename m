Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135E57D224;
	Wed,  9 Sep 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969605; cv=none; b=Ou7KrG1zOaAF8h3wMKip61cj6yPVjtAUqYK8zlRNISTittYGhaYSQef6AhkIslYPswfPdThuOI5ZR7xOqWuZMpH0OD/ZZKrvjP8xQqNabolJPpppS7Sc2VTqL6yzTQ3jeJV4/foGj1lmKTLoFKt8Y+9DYhkqqp5ovHsFzBGgJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969605; c=relaxed/simple;
	bh=Kqj2JHtBcUKCk/mZ/xmpQILCIBjygqDL7l/MnP2aod8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5iJtDCbrX2i5DDgdXZYMNZXwU6/54opcfVhK97RHN4oKzJOpCGrLF5tCQCcVA8oVw0Nb4H8SnP4SfsGJBYU8fTiFImajPYzMl+EYOvcLKiikrkuxxDO7PO0hP1KD7v82BIEo6CFuptNYiOZgXUQntKpWiOFb74G9B1r7C2SIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV3bzImH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV3bzImH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08AE1F00A3A;
	Wed,  9 Sep 2026 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969604;
	bh=hX5P1RT2s80XT4iv6hHkolUt8vW9FgOLelFgrlevLcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OV3bzImHtiygUhMGL2doqY4HKQeuM3a4O7BbNVVLN00QFnomP8PTt6Kxl7IEGm4vp
	 irXKD6xJa1itbSABTM/7dQNWwok4ByW6/WDOyn1n+15g254HxGZG6WzXPpReUi46Bw
	 W4yde8GEFragLdXVeWuk6g2Z5JjliD/FEA8+DqS50l8LXWJRADQLlI71KFzo4pkW2B
	 oG7ObA3ES4or98UFX7N9FGsytYPd/OHdEJ3iyoBhJS624dP6VafyjoLgpCArxx4sPo
	 0Sd3OG7LsysvfsFGm/GYahJ16V8TF/OPBwp1QlBTc2lKplOwj1HK2J0RO+hTh+pc/z
	 qerNOWQ60jKpQ==
Date: Wed, 9 Sep 2026 16:59:58 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v9 2/5] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Message-ID: <20260909155958.GC2133376@google.com>
References: <20260902134417.1270552-1-lee@kernel.org>
 <20260902134417.1270552-2-lee@kernel.org>
 <CAF8JNhJTZ8t_MaopSihkiDZgadhdphKJirDzqjNb9+5dTeH8Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8JNhJTZ8t_MaopSihkiDZgadhdphKJirDzqjNb9+5dTeH8Nw@mail.gmail.com>

On Tue, 08 Sep 2026, Ping Cheng wrote:

> I tested the devices that I can reach, mainly the ones released in the
> past 10 years or so. The tablets all worked. No crashes whatsoever. I
> am comfortable to give the whole set of this version an acked-by and a
> tested-by to help it move forward.
> 
> Acked-by: Ping Cheng <ping.cheng@wacom.com>
> Tested-by: Ping Cheng <ping.cheng@wacom.com>
> 
> With that said, the SW_MUTE_DEVICE capability assigned through a
> softkey is not properly recognized. I've figured out the root cause. I
> will submit a patch after this set is merged. The main value of this
> set is to resolve the Use-After-Free issue and the redesign of the
> shared sibling data lifecycle. The individual softkey feature can be
> addressed separately.
> 
> Hope my testing results make the maintainers feel comfortable too.

Thanks for these.

Sorry, I didn't see them before submitting v10 this morning.

-- 
Lee Jones
