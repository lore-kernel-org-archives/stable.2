Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80E25EF87;
	Tue,  8 Sep 2026 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788847159; cv=none; b=RUXKgCQtjXHlHmdE7JU4dHVwq+JC99X1XRZy4uypfaLwi2T+UB1mdJCOJtDQENILIWWXYyE3WwfePvvCjsdKMyIj+EEJTXdJIGDxtUlJVY6AZ+5096bllPoEx7B8yxXWN41LLqTl06j++v7qwdiSfPSvG9bNobc+m8CWkeolssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788847159; c=relaxed/simple;
	bh=/gW4VDD9GW2evLGXlAFwVnGfmvnYTo0xO/4UdHgGs9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke0Tn3rR2C/MMqG/naFvk3RjaM+k2HrbAV/AJhG1lr08piSlRIWcmJvDBUMwyAPefzHwMiVGzCgSVBar3Vr64CIgUjDwOVCBAGsip+hZBkq/5VwFoOEZiOXPBxh1WsJ2ptJO1y2rkuTopM9m47etfLmcwrNHQBGESbPYec9LDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=anmFtpAf; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="anmFtpAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=TVOCml1fPNtCirdGLx+WuTkZ6CGbflsL+RoyjnnUg/I=;
	b=anmFtpAf1s8vWMp++AEdLBmrP6YqwE5impzDPiAH+5NU9cGTxjlVMHmFYFAKPh
	Y3B4WlIC34wvTOOU80hktjZ42XOpWPa/H48HMaMgNypUuxLaRXZ/BNmp61plzg51
	mP4HSdWIJSiOBbDrYnWfr1SWt8Sj7SaUF13NjBNmDq5no=
Message-ID: <152a5d66-d4f6-4b90-b30a-8777876ee319@163.com>
Date: Tue, 8 Sep 2026 13:58:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sched: Create a fake device for KUnit tests
To: phasta@kernel.org, Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>, stable@vger.kernel.org
References: <20260903121558.782854-1-oushixiong1025@163.com>
 <fcecfac828dc3f338d59125d6f0306534e1e2429.camel@mailbox.org>
Content-Language: en-US
From: Shixiong Ou <oushixiong1025@163.com>
In-Reply-To: <fcecfac828dc3f338d59125d6f0306534e1e2429.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXuRP5o59qwMfPBQ--.9328S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF48AF4rXFy8JF47KrWxJFb_yoW8AF1UpF
	WvvayYkr4DtryjgF429rWxZ347KrsIkryUKryrKw1SkFn0gFn3WFs5JrW3tryxAr95CFWa
	v3Wagw17XF4DtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4RyquWqfo-xsigAA3i

Hi,

First of all, thanks for the review and the suggestions.
I had already sent v3 by the time your full comments came in -- here is
the v3 patch for reference:  https://lkml.org/lkml/2026/9/4/547

Both points will be addressed in v4 later.


On 2026/9/4 15:02, Philipp Stanner wrote:
> On Thu, 2026-09-03 at 20:15 +0800, oushixiong1025@163.com wrote:
> […]
>
>> +
>>   #include "sched_tests.h"
>>   
>>   /*
>> @@ -288,6 +290,7 @@ static const struct drm_sched_backend_ops drm_mock_scheduler_ops = {
>>    */
>>   struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
>>   {
>> +	static unsigned int instance;
> I know statics are initialized to 0 automatically, but writing it out
> explicitly is probably advantageous for readability, especially since
> we're incrementing.

One note: this trips checkpatch's "do not initialise statics to 0"
error, so I followed your suggestion over the checkpatch rule.


>>   	struct drm_sched_init_args args = {
>>   		.ops		= &drm_mock_scheduler_ops,
>>   		.num_rqs	= DRM_SCHED_PRIORITY_COUNT,
>> @@ -297,11 +300,19 @@ struct drm_mock_scheduler *drm_mock_sched_new(struct kunit *test, long timeout)
>>   		.name		= "drm-mock-scheduler",
>>   	};
>>   	struct drm_mock_scheduler *sched;
>> +	struct device *dev;
>> +	char name[64];
>>   	int ret;
>>   
>>   	sched = kunit_kzalloc(test, sizeof(*sched), GFP_KERNEL);
>>   	KUNIT_ASSERT_NOT_NULL(test, sched);
>>   
>> +	snprintf(name, sizeof(name), "%s-%u", args.name, ++instance);
> Any particular reason why you begin with index 1?

No particular reason -- switched to instance++ so the numbering
starts at 0.

The updated v4 patch will be send later.
Thanks again for your time and for catching these points.

Best regards,
Shixiong Ou


