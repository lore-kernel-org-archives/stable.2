Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10069468C09;
	Fri,  4 Sep 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560530; cv=none; b=Jdp+JGPhaLP3DsnIHmkc36i6exXK83PZ/8Mrp9wpwVyGArZP5OBaOIMhmKqqs7j8pwadNTrVkhDtLgHygs5uTdSjE/qnwPFH93S6rxZQCbKlBh8hvS1OgaQ0sCTOjNwboR5IHR815YMmss+6Kn918IkpnC9KIwkVFYyLNI7sVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560530; c=relaxed/simple;
	bh=oPVDPR9G8pvW4j/ptfuNum9f+WDa0bplq2EWwiuQ/Gw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mnwMh3iJ8JBZ9krTZsjh4wAdBqW6xeNIoL0qLC5/aSpW6KHFKDNsOpy8UiyFOtW/MsP69R14iT5GlCmXObDHIpAWl5smtbfl0gukPApbyeRaDDz6gz9c+anJ6Bi9krHDeF5ifv1W4K3zfCgg6fViAXMBtmRgIcEovgwKOD+3PJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeReDTJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeReDTJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D754A1F00A3D;
	Fri,  4 Sep 2026 22:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560515;
	bh=qpMhiQLjSPn+IixWCKsh67n6JvkjgKbGv6IoFQYXMtY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WeReDTJRV4eHcQJLUv8y1s8QoBUOva0wyvkASASXWjzIg0HngUoaR8PYAsmJkDXsM
	 ySHFporkqf2DiYlc22O8xguBDjupK0PuSUcmlQQC4N1R/dl6k30h5BMnHvjz/skmmY
	 vJhw4uq79PuiVjlpzLy6AthE3wqlrpc+l6kRjyDsIA66hxEAcaU7RlDENiaaQEobmZ
	 M/wRwFGz5ZvawP2fn8wNkRlYXjsRYNFLvMNTWinAg5eS/+5R3UGrk4DlI3KMIhIf+U
	 vq0gwVdLafuCByunbpEZVT9H+zfGDBQdepHtBMpYbOH6MVcesDWtMheRx+iuGqVqOs
	 TGv+kNnUq/Gkw==
Content-Type: multipart/mixed; boundary="===============4410765396966452123=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d6eed7bdb5d4ba036cfcc7255b9e01fb111cd936be81ee00fff57d3cae7b02ce@mail.kernel.org>
In-Reply-To: <20260904080524.3872926-1-tristmd@gmail.com>
References: <20260904080524.3872926-1-tristmd@gmail.com>
Subject: Re: [PATCH] HID: core: fix device cleanup on allocation failure
From: bot+bpf-ci@kernel.org
To: tristmd@gmail.com,jikos@kernel.org,bentiss@kernel.org
Cc: linux-input@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,tristan@talencesecurity.com,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 22:21:54 +0000 (UTC)

--===============4410765396966452123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> hid_allocate_device() calls hid_destroy_device() in its error path when
> hid_bpf_device_init() fails.  hid_destroy_device() in turn calls
> hid_bpf_destroy_device() which invokes synchronize_srcu() and
> cleanup_srcu_struct() on the SRCU structure.  However, at this point
> init_srcu_struct() has not been called (or has failed), so the SRCU
> internal pointers are all zeroed from kzalloc.  Dereferencing them
> causes a general protection fault:

Is the reasoning here fully accurate?

Looking at hid_bpf_device_init() in drivers/hid/bpf/hid_bpf_dispatch.c,
it returns the result of init_srcu_struct(&hdev->bpf.srcu), so
init_srcu_struct() is always called before the error path is taken.

When init_srcu_struct() fails (specifically init_srcu_struct_fields() in
kernel/rcu/srcutree.c), the failure paths explicitly free and NULL the
pointers:

kernel/rcu/srcutree.c:init_srcu_struct_fields() {
    ...
err_free_sda:
    free_percpu(ssp->sda);
    ssp->sda = NULL;
err_free_sup:
    kfree(ssp->srcu_sup);
    ssp->srcu_sup = NULL;
    ...
}

So the SRCU internal pointers are NULL due to init_srcu_struct()'s
rollback on failure, not because init_srcu_struct() was never called or
because they are still zeroed from kzalloc.

Could the commit message be more precise? Something like:
"init_srcu_struct() was called but failed, and it rolled the SRCU
internal pointers back to NULL"

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a3ff0514f9cd..d8df23f67f1f 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -3115,7 +3115,12 @@ struct hid_device *hid_allocate_device(void)
>  	return hdev;
>
>  out_err:
> -	hid_destroy_device(hdev);
> +	/*
> +	 * hid_destroy_device() cannot be used here because
> +	 * hid_bpf_device_init() failed and the SRCU struct was never
> +	 * initialized.  Release the device directly.
> +	 */
> +	put_device(&hdev->dev);
>  	return ERR_PTR(ret);
>  }

Should the comment say "was never successfully initialized" rather than
"was never initialized"?

As shown above, hid_bpf_device_init() returns init_srcu_struct()'s
result, so init_srcu_struct() is always called before reaching this
error path. It failed after partially initializing, then rolled back.

The distinction matters for future readers trying to understand the
ordering inside hid_bpf_device_init().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33923149618
--===============4410765396966452123==--
