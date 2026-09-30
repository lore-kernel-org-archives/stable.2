Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D982D662F;
	Wed, 30 Sep 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753841; cv=none; b=O6uhNKwMYgqlPwsT7MXeGPw4M0qX1K6c/nn1Tpfw8Tr+G+1GTKp4WlbaEQxdA0dpvrJkNUtVZ7w72lujUeLftihmS06szg5HXoMvbzj3ZoTY2Tvib7FxPJWuU2gjWbgScwRoOkS/ElGnRi+57qlvOnFe+sJmKvbRV0kAbjeDO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753841; c=relaxed/simple;
	bh=q583Vuo00DaNmQkzLneKIqegshtifcF0GMHRsSSz/K4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W6zhV3LOnaps2nrYF7KH//wndnRIoJA86Go0gw8AS85fs6/0M3Zjg70lZY1Q70yIMZriOEWsyWQzn3J81DEnsq8fVqTTCfBc5p6mk1zPPv6BF0PLyRSw/b+nnezTt5UBBKWBbHFqIviIn0ImCw3pdEraq/mqGPgPWL3xGp3eTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSeEEJWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSeEEJWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8CE1F000FF;
	Wed, 30 Sep 2026 07:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790753839;
	bh=qPO2lw1+79erqGqMxWWT2r7/JSusNTUmIuDxiPR1T9A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=RSeEEJWTUISA4Xb3aGin4FOZkGfc7pAlpZkL51IuLixgqW7X0vS9lAZVycEgtiOEm
	 STLCa9T+wxWrcnmWAAQcu1bVpP98FpsBsV6Y3SzLjgSomMNIUm0+rpYqPxf+eGFYk/
	 Gwg5vli5FXJL2M7rrJbYIfB8joz9rp7Xt/fkIGJHFHmXZatt3S8K5AUX191MZ9D6Zr
	 tNj4QhBL/3t0wdB3DzthNqqtUFPiwkzIRu6007sQDiKYUphsyJtzZ+lJoITd0KIYFE
	 vXZ8L/ugzeBtFnKDJ5QSOW9HufqMXxpjw446fVF4ijziWlitt+fGg4fYiUr0fSrvqS
	 RISvqi/jMbxXA==
Message-ID: <56fc727a-cfd6-4114-b0f1-4c1e6b39f8e9@kernel.org>
Date: Wed, 30 Sep 2026 09:37:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH fixes v3] media: vivid: check for NULL dev in
 vivid_probe() control setup
To: Rohinthan P <rokinthanp03@gmail.com>, hverkuil@kernel.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+caaca441bae2799984d3@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260926084318.12161-1-rokinthanp03@gmail.com>
 <20260927033306.14125-1-rokinthanp03@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260927033306.14125-1-rokinthanp03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/09/2026 05:33, Rohinthan P wrote:
> In vivid_probe(), after creating instances, the driver iterates
> through vivid_devs[0..n_devs-1] to populate HDMI and S-Video
> 'Connected To' controls. However, it dereferences dev->has_vid_out
> without verifying that dev is non-NULL.
> 
> If an instance fails during creation, vivid_devs[i] remains NULL,
> causing a general protection fault:
> 
>     Oops: general protection fault
>     KASAN: probably user-memory-access in range
>     [0x0000000000005f38-0x0000000000005f3f]
>     RIP: 0010:vivid_probe+0x579/0x10d0
> 
> Add NULL pointer checks in both loops in vivid_probe() before accessing
> vivid_devs[i].
> 
> Fixes: d7c969f37515 ("media: vivid: Add 'Is Connected To' menu controls")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+caaca441bae2799984d3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=caaca441bae2799984d3
> Signed-off-by: Rohinthan P <rokinthanp03@gmail.com>
> ---
> Changes in v3:
> - Add "fixes" branch prefix to subject and base-commit info targeting
>   media-committers.git fixes branch to satisfy media-ci test-valid-ancestor check.

Don't add a fixes prefix, it serves no purpose.

> - Add Cc: stable@vger.kernel.org for media-patchstyle check.
> 
> Changes in v2:
> - Remove .suppress_bind_attrs = true so driver bind/unbind via sysfs
>   remains supported as required by the test-media test suite.
> - Update author name to "Rohinthan P".
> 
>  drivers/media/test-drivers/vivid/vivid-core.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
> index 62cfb5f..1860ad6 100644
> --- a/drivers/media/test-drivers/vivid/vivid-core.c
> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
> @@ -2116,17 +2116,19 @@ static int vivid_probe(struct platform_device *pdev)
>  	for (int i = 0; i < n_devs; i++) {
>  		struct vivid_dev *dev = vivid_devs[i];
>  
> +		if (!dev)
> +			continue;

As I mentioned in my earlier reply: AFAICT this can never happen.

Looking at the code, vivid_devs is non-NULL for all indices 0...n_devs-1. See the for loop
at the start of vivid_probe where the instances are created.

So if vivid_devs[i] is ever NULL, then that's the bug that needs to be addressed:
why is it NULL at all?

Do you have proof that it is actually NULL?

The syzkaller report shows this at the start of the crash log:

cec: vivid-003-vid-cap0: kthread_run() failed

So why does it fail, and why does it cause a crash later on.

Anyway, I'm rejecting this patch since it doesn't address the real cause.

Regards,

	Hans

>  		if (!dev->has_vid_out)
>  			continue;
>  		for (int j = 0; j < dev->num_outputs && hdmi_count < MAX_MENU_ITEMS; ++j) {
>  			if (dev->output_type[j] == HDMI) {
> -				vivid_ctrl_hdmi_to_output_instance[hdmi_count] = vivid_devs[i];
> +				vivid_ctrl_hdmi_to_output_instance[hdmi_count] = dev;
>  				vivid_ctrl_hdmi_to_output_index[hdmi_count++] = j;
>  			}
>  		}
>  		for (int j = 0; j < dev->num_outputs && svid_count < MAX_MENU_ITEMS; ++j) {
>  			if (dev->output_type[j] == SVID) {
> -				vivid_ctrl_svid_to_output_instance[svid_count] = vivid_devs[i];
> +				vivid_ctrl_svid_to_output_instance[svid_count] = dev;
>  				vivid_ctrl_svid_to_output_index[svid_count++] = j;
>  			}
>  		}
> @@ -2134,13 +2136,17 @@ static int vivid_probe(struct platform_device *pdev)
>  	hdmi_count = min(hdmi_count, MAX_MENU_ITEMS);
>  	svid_count = min(svid_count, MAX_MENU_ITEMS);
>  	for (int i = 0; i < n_devs; i++) {
> -		for (int j = 0; j < vivid_devs[i]->num_hdmi_inputs; j++) {
> -			struct v4l2_ctrl *c = vivid_devs[i]->ctrl_hdmi_to_output[j];
> +		struct vivid_dev *dev = vivid_devs[i];
> +
> +		if (!dev)
> +			continue;
> +		for (int j = 0; j < dev->num_hdmi_inputs; j++) {
> +			struct v4l2_ctrl *c = dev->ctrl_hdmi_to_output[j];
>  
>  			v4l2_ctrl_modify_range(c, c->minimum, hdmi_count - 1, 0, c->default_value);
>  		}
> -		for (int j = 0; j < vivid_devs[i]->num_svid_inputs; j++) {
> -			struct v4l2_ctrl *c = vivid_devs[i]->ctrl_svid_to_output[j];
> +		for (int j = 0; j < dev->num_svid_inputs; j++) {
> +			struct v4l2_ctrl *c = dev->ctrl_svid_to_output[j];
>  
>  			v4l2_ctrl_modify_range(c, c->minimum, svid_count - 1, 0, c->default_value);
>  		}

