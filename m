Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385833F595;
	Tue, 18 Aug 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072225; cv=none; b=rlh4jUGilkC64S+TAIWFnoL2Y7kQidicoY3FrvGxUnLfphuU6yldeNha7cJkan4mGUCumBnDKm4RhGVKCrK6zHuMk2kwK+AMxvUzNC2L2gburb11w6mohnXjEL9ZSUPM2OapzpiUjsgWEA5h7UGH4OGHhAtAQmH9i5afsT5XI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072225; c=relaxed/simple;
	bh=44z5lgFGYGRPX9DUgWmoiqY3j7JJlYIBmB1UHvvNdjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B01WepaV8zgKDJtg1Tu1b2HPZ8Bgqq6GZ3aCZSoNOJr9kjjZ+mYco83jWB+S4ojcbLYBG7xjip/sdR4ViqM489kmClLuRe0e+Fvo05hqvrbId3vjQ1O+Obbcw0CUE4U0/wCeHWCDE3ko4XkOJ2pT4ZqyLYOpK/YRxs3+aYm70Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=jzPRBktI; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="jzPRBktI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C399311C31D;
	Tue, 18 Aug 2026 18:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1787072214;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XW+R/bVPewEY+UjFdeGzB0LwlhlvVKED2LQpFCgnlRM=;
	b=jzPRBktIZDIaN/tn7j9TdnX6RSM0bItaYdpo0QLLxOwHxlwENW/nMC1mrciVjPr/cmn1vl
	tXGHDoeY0BwYasFgL6D0eZC4vA3/CzLG/shFcBcDQCe95qpEZQFIcu52aFweE+TvhOxmFG
	n0HxIgs7FAJaJRrq7a+0E4ACtRNXNLFH9UgCgmm3xahFF0RlyFvC3Pn1MXeEujpMwPjFCw
	h3HBo+9xQCnu9rkVruTrjVj33vSOt3o2b0oiuTkm7A/8bOsDWqR31liPeG4OSAfOKJVf5N
	JOJNuTkEYCqfhr8Fv9oRRjG/75usj0JJau0oGOwbLiFrbarZ0w1V0YRwjF0lCg==
Message-ID: <dfac3134-920e-498e-a59b-720a6c51b82a@nabladev.com>
Date: Tue, 18 Aug 2026 18:56:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: mux: Fix typec_switch_match()
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org
References: <20260817182302.146546-1-marex@nabladev.com>
 <aoSFjbydIiu4KyW0@venus>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aoSFjbydIiu4KyW0@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 8/18/26 6:24 PM, Sebastian Reichel wrote:

Hello Sebastian,

> On Mon, Aug 17, 2026 at 08:22:39PM +0200, Marek Vasut wrote:
>> The fwnode_typec_switch_get() sporadically returns NULL instead of an
>> -EPROBE_DEFER for orientation-switch described in DT. This makes it
>> impossible to discern whether the DT does describe an orientation-switch
>> which did not probe yet, or whether the DT does not describe the switch.
>> This happens with gpio-sbu-mux connected to an I2C GPIO expander.
>>
>> The class_find_device() on typec_switch_match() may return NULL in case
>> the mux did not probe just yet early on boot. The sw_devs[] array can be
>> empty on boot as well. If these two conditions occur, then the conditional
>> if (to_typec_switch_dev(dev) == sw_devs[i]) evaluates to true and the match
>> function returns NULL, which propagates to fwnode_typec_switch_get() which
>> makes it look as if the orientation-switch was not described in DT.
>>
>> This is incorrect, because the mux driver will probe a bit later on, but
>> at that point, the caller of fwnode_typec_switch_get() already got the
>> NULL return value. The NULL return value also does not trigger IS_ERR(),
>> therefore the caller driver interprets this as if the orientation-switch
>> is not described in DT, and does not return -EPROBE_DEFER to try again,
>> even if it should.
>>
>> Fix this by checking the class_find_device() return value, and return
>> -EPROBE_DEFER if it is NULL right away. If the return value is not NULL,
>> perform the deduplication test, and if that test passes, consider the
>> return value to be already non-NULL.
>>
>> Fixes: a53b4f9c51a9 ("usb: typec: mux: avoid duplicated orientation switches")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> ---
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Cc: kernel@dh-electronics.com
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-usb@vger.kernel.org
>> ---
>> NOTE: A similar change was reverted in
>>        f576c75f95a5 ("Revert "usb: typec: mux: avoid duplicated mux switches"")
>>        Maybe the orientation switch commit also needs a revert ?
>>        Or the mux switch revert can be undone and fixed using this NULL check ?
>> ---
> 
> This revert negatively affects Rockchip once my USB-C rework for
> USB-DP lands and I undid it locally. I've just not yet found the
> time to investigate why it regresses the X1E platform to reintroduce
> the feature. Maybe you found the root cause and fix already, but
> investigating with my T14s Gen6 Snapdragon is on my TODO list.
> 
> FWIW this patch is
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Could you revert f576c75f95a5 ("Revert "usb: typec: mux: avoid 
duplicated mux switches"") and apply the following patch (equivalent to 
this patch, applies to mux instead of switch) and see if that fixes the 
T14s for you too then ? If yes, than, I think this might be the proper 
fix rather than the revert:

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 4a4297f15aad3..afa6fc1813978 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -294,6 +294,8 @@ static void *typec_mux_match(const struct 
fwnode_handle *fwnode,

         dev = class_find_device(&typec_mux_class, NULL, fwnode,
                                 mux_fwnode_match);
+       if (!dev)
+               return ERR_PTR(-EPROBE_DEFER);

         /* Skip duplicates */
         for (i = 0; i < TYPEC_MUX_MAX_DEVS; i++)
@@ -303,7 +305,7 @@ static void *typec_mux_match(const struct 
fwnode_handle *fwnode,
                 }


-       return dev ? to_typec_mux_dev(dev) : ERR_PTR(-EPROBE_DEFER);
+       return to_typec_mux_dev(dev);
  }

  /**
