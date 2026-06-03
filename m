Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ECB46AEE5;
	Wed,  3 Jun 2026 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486618; cv=none; b=Icbth+7waE+5y04Cu9h/eNsqgZFr59L0vhYTWDNQMBtXVjfJp0mXNBl77DBmBCclZxRjC4HG+EKtW2DEcUJJrA1xRzRt8sMDtd9K+CIlwiy4cJE92TCtlzZ7ohqWUeyRSqBmd/OHQcCeIbUszhJ2nUxf1yy4Oi8ctfcqhqq50ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486618; c=relaxed/simple;
	bh=GXtemVvQe32JT57DRWEfRbfG3iQHNFXNIcdyeU1cKKs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uVYHho0o2nFlXUh+9fIpruZcDD1pX3o85rYAm6e9xWiWG2Oth98/4YoZNxPXApGi8QzWboJorke2Yio5g9fG9bFkPkeHDmA2plDUlgWWoZIOiVTyWMBJZjAkZ93pj6p4wRcPB7a+l9v+CR4iJPHYBe9obHaGERu+1V0FcP3Hc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+l+YvhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+l+YvhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7631F1F00898;
	Wed,  3 Jun 2026 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486616;
	bh=/4A0xCv5HhFvDirt4xZLIckm0i7h6JzjZugBoUcXNR8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P+l+YvhRqoYRYIAnghXWuK9AxYaXE4i6xfGgRj1kReI1WPD713ebrzqioVUAB9pob
	 ckNkTBKOuK16GgariWjKzTzEhDnZYa0gRtNsuiiiJJ0djwTF8baMi6SfHgeJiFwgOu
	 w0LdbrHDdyNJKEQcanJq36RqcJhZnDM8Iyh4SZSozY80qY1N0oEQ45zrnfV3u2uz3d
	 1yF/RvE0iJO7kg1qbt3PM1oJCxesQI74UWx2R0FohIU8SqYInPG+xAJoCsqFi1S2eA
	 EGR8uW9/ljh4vTXT9VyNXTTIYZzAvpxVYtbxKoGsiBM/Rp1P0eLsxRqEoWms0pt1vp
	 V2xcaWr+y78QA==
Content-Type: multipart/mixed; boundary="===============3363437374747764375=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01ff25bf2f60666db05099be88f1a67bea2dd97fe7114a9bbe7c190252eebe3a@mail.kernel.org>
In-Reply-To: <20260603105317.944304-4-dawei.feng@seu.edu.cn>
References: <20260603105317.944304-4-dawei.feng@seu.edu.cn>
Subject: Re: [PATCH v3 3/3] bpf: Restore sysctl new-value from 1 to 0
From: bot+bpf-ci@kernel.org
To: dawei.feng@seu.edu.cn,martin.lau@linux.dev
Cc: emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kees@kernel.org,joel.granados@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,jianhao.xu@seu.edu.cn,dawei.feng@seu.edu.cn,stable@vger.kernel.org,zilin@seu.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Jun 2026 11:36:56 +0000 (UTC)

--===============3363437374747764375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4bf0ec94e719..35d1f1428ef3 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1936,7 +1936,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>
>  	kfree(ctx.cur_val);
>
> -	if (ret == 1 && ctx.new_updated) {
> +	if (!ret && ctx.new_updated) {

The success check now tests !ret, but the kerneldoc above
__cgroup_bpf_run_filter_sysctl() still describes the old convention:

kernel/bpf/cgroup.c:
 * This function will return %-EPERM if an attached program is found and
 * returned value != 1 during execution. In all other cases 0 is returned.

Since bpf_prog_run_array_cg() returns 0 on success rather than 1, should
that line read "returned value != 0" to match the new check?

This was raised by the bpf-ci reviewer on both v1 and v2
(https://lore.kernel.org/all/45201482368d330f6301ea4d90e29fa1585bf985c12a191d9fcd975087eb0649@mail.kernel.org/)
but the wording does not appear to have changed in v3.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26881443787
--===============3363437374747764375==--
