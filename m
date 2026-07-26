Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC75175A83;
	Sun, 26 Jul 2026 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785063782; cv=none; b=lIXPBzMbU4QKd+FkgZZEf4MhpVVN0a37xO9MGkoQJR1SzOO5geCaA3cVE1WvY+vkJ2ax13OLioOnhE9CL6AYaKvdsrJDgMWTs5iOSZYKfXtsFBTKolnYR9QyW+KynekSsb4HHIjHZWCAcEZFQwXUOeA2qhDEiGNYOqglX7xrAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785063782; c=relaxed/simple;
	bh=KJjg0ZZpBnaIQrk0g/Ujd7zgc2P3TXJqPF4hE9etMFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijXz6qoghw+Yf3yC8gZ2rcc1+RtxyZoi4KN+VlFXBJq3YL4AdLb8ZThnLRigiwHr1ZWiijeGpCo5psJEFnbl0RGSqeSpZ/vOPknEbdvb3BHAui2SyMlCkLT6roEWzeBqcyVQGgYVjMQqllUKTC/9+1ya+fB6E6o+RWdZo0t//hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [123.116.46.73])
	by APP-03 (Coremail) with SMTP id rQCowAB3gkB152VqljxyAQ--.26964S2;
	Sun, 26 Jul 2026 18:54:46 +0800 (CST)
Message-ID: <07a3a3ff-a92a-41b7-8cdd-984f3e88bed4@iscas.ac.cn>
Date: Sun, 26 Jul 2026 18:54:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y/5.15.y] KVM: VMX: Make vmread_error_trampoline()
 uncallable from C code
To: Vivian Wang <dramforever@live.com>, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <OSCPR01MB13468557BE10B1EAC08EAF183C6CD2@OSCPR01MB13468.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <OSCPR01MB13468557BE10B1EAC08EAF183C6CD2@OSCPR01MB13468.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAB3gkB152VqljxyAQ--.26964S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYq7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
	6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
	1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvE
	ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I
	8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIE
	c7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GF
	yl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7GYLDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 7/26/26 18:44, Vivian Wang wrote:

> [...]
>
> Signed-off-by: Vivian Wang <dramforever@live.com>
> ---
> Note: This is my personal email. I will reply from my work email to
> confirm I am the same person as Vivian Wang <wangruikang@iscas.ac.cn>.

Hi, I'm Vivian Wang <wangruikang@iscas.ac.cn> and this is confirmation
that Vivian Wang <dramforever@live.com> is my personal email.

Unfortunately I don't have a well-known PGP key or something so this is
will have to do.

